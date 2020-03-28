#!/usr/bin/env python3
from __future__ import print_function

import os
import pathlib
import subprocess
import logging
from time import sleep
from importlib.util import find_spec


is_debug_on = bool(os.environ.get('DEBUG'))

logging.basicConfig(format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', level=logging.DEBUG)
log = logging.getLogger(__name__)
log.disabled = not is_debug_on


def setup_before_installation():
    execute(
        'Installing: git, pip, wget and cloning repo',
        via_apt=[
            'git',
            'python-pip',
            'python3-pip',
            'wget'
        ],
        via_pip=['tqdm'],
        via_os=[
            (
                lambda: not is_directory_exists('~/.dotfiles'),
                'git clone https://github.com/kuzxnia/dotfiles.git $HOME/.dotfiles'
            )
        ]
    )


def setup_vim():
    execute(
        'Vim',
        via_apt=['vim'],
        via_os=[
            (
                lambda: not is_directory_exists('~/.Vundle'),
                'git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim'
            )
        ],
        link_files=['.vimrc']
    )


def setup_neovim():
    execute(
        'Neovim',
        via_apt=['neovim'],
        via_pip=['pynvim'],
        link_files=['.config/nvim/init.vim']
    )


def _setup_search_tools():
    execute(
        'Search utilities',
        via_apt=['bat', 'ripgrep'],
        via_os=[
            (
                lambda: not is_directory_exists('~/.fzf'),
                'git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf',
                '$HOME/.fzf/install --all'
            ),
            (
                lambda: check_installed('fd'),
                'wget -q https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb -O $HOME/fd.deb',
                'sudo dpkg -i $HOME/fd.deb'
            ),
            (
                lambda: check_installed('jump'),
                'wget -q https://github.com/gsamokovarov/jump/releases/download/v0.23.0/jump_0.23.0_amd64.deb -O $HOME/jump.deb',
                'sudo dpkg -i $HOME/jump.deb'
            )
        ]
    )


def setup_tmux():
    execute(
        'Tmux',
        via_apt=['tmux'],
        link_files=['.tmux.conf']
    )
    execute(
        'Tmux plugins',
        via_os=[
            (
                lambda: not is_directory_exists('~/.tmux/plugins/tpm'),
                'git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm',
                'tmux source-file $HOME/.tmux.conf',
                '$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh'
            )
        ]
    )


def setup_git():
    execute(
        'git',
        via_os=[
            'wget -q https://github.com/dandavison/delta/releases/download/0.0.15/git-delta_0.0.15_amd64.deb -O $HOME/delta.deb',
            'sudo dpkg -i $HOME/delta.deb'
        ],
        link_files=['.gitconfig']
    )


def setup_libs():
    execute(
        'Basic libs',
        via_apt=[
            'exuberant-ctags',
            'ripgrep',
            'flake8',
            'pipenv',
            'htop',
            'zip',
            'ranger',
            'highlight',
        ],
        via_os=[
            (
                lambda: check_installed('exa'),
                'wget -q https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip -O $HOME/exa-linux-x86_64-0.9.0.zip',
                'unzip $HOME/exa-linux-x86_64-0.9.0.zip -d $HOME',
                'sudo mv $HOME/exa-linux-x86_64 /usr/local/bin/exa'
            ),
            (
                lambda: True,
                'wget -q https://github.com/jarun/googler/releases/download/v4.0/googler_4.0-1_ubuntu18.04.amd64.deb -O $HOME/googler.deb',
                'sudo dpkg -i $HOME/googler.deb'
            )
        ]
    )


def setup_kitty():
    execute(
        'Kitty',
        via_apt=['kitty'],
        via_os=[
            'mkdir -p $HOME/.config/kitty',
            'curl -o $HOME/.config/kitty/snazzy.conf https://raw.githubusercontent.com/connorholyday/kitty-snazzy/master/snazzy.conf'
        ],
        link_files=['.config/kitty/kitty.conf']
    )


def setup_zsh():
    execute(
        'Zsh',
        via_apt=['zsh'],
        via_os=[
            (
                lambda: not is_directory_exists('$HOME/.oh-my-zsh'),
                'sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"<<"exit"'
            ),
            'git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions',
            'git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search',
            'git clone https://github.com/zdharma/fast-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting',
            (
                lambda: not check_installed('echo "$SHELL" | grep -q *zsh$'),
                'sudo chsh -s "$(which zsh)"'
            )
        ],
        link_files=[
            '.zshrc',
            '.zsh/abbreviations.zsh',
            '.oh-my-zsh/themes/raw.zsh-theme'
        ]
    )


class InstalationStatistic:
    SUCCES = 0
    FAIL = 0
    SKIP = 0

    @classmethod
    def summarize(cls):
        print(
            '\033[92m' if cls.FAIL == 0 else '\033[91m'
            'Installed sucessfuly {}, skipped {}, failed {}{}'
            .format(
                cls.SUCCES,
                cls.SKIP,
                cls.FAIL,
                ' stderr logs in .dotfiles.log' if cls.FAIL != 0 else ''
            )
        )


def execute(msg, via_apt=None, via_pip=None, via_os=None, link_files=None):
    def gen_commands():
        for command in via_apt:
            yield 'sudo apt-get install -y {}'.format(command) if check_apt_installed(command) else None

        for command in via_pip:
            yield 'yes | pip install {0}; yes | sudo pip3 install {0}'.format(command)

        for command in via_os:
            if isinstance(command, tuple):
                contition, *commands = command
                for command in commands:
                    yield command if contition() else None
            else:
                yield command

        for path in link_files:
            if isinstance(path, tuple):
                yield f"mkdir -p {os.path.dirname(path[1])} && ln -sf $HOME/.dotfiles/{path[0]} {path[1]}"
            else:
                yield f"mkdir -p $HOME/{os.path.dirname(path)} && ln -sf $HOME/.dotfiles/{path} $HOME/{path}"

    if find_spec('tqdm'):
        from tqdm import tqdm
    else:
        def tdqm(x, msg, *args, **kwargs):
            print(msg)
            return x

    via_apt = via_apt or []
    via_pip = via_pip or []
    via_os = via_os or []
    link_files = link_files or []

    commands_amound = sum(
        1 if not isinstance(command, tuple) else len(command)-1
        for command in via_apt + via_pip + via_os + link_files
    )

    for command in tqdm(gen_commands(), msg, total=commands_amound, smoothing=0.5):
        run(command)


def is_directory_exists(path):
    return pathlib.Path(path).expanduser().exists()


def check_installed(command):
    return bool(subprocess.run(command, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL).returncode)


def check_apt_installed(package):
    return check_installed('dpkg --get-selections | grep -q "^{}*[[:space:]]*install$"'.format(package))


def check_pip_installed(package):
    return check_installed('pip freeze | grep -q {0} && pip freeze | grep -q {0}'.format(package))


def run(command):
    if not is_debug_on:
        sleep(0.01)  # pleasing to the eye, debug off

    if not command:
        InstalationStatistic.SKIP += 1
        log.debug('Command skipped.')
        return

    log.debug('Executing command=%s', command)

    output = subprocess.run(command, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE)

    if output.returncode == 0:
        log.debug('Command executed succesfuly.')
        InstalationStatistic.SUCCES += 1
    else:
        log.error('Found errors %r', output.stdout)
        InstalationStatistic.FAIL += 1
        if not is_debug_on:
            with open('.dotfiles.log', 'wb') as f:
                f.write(output.stderr)
        else:
            exit(0)  # to fail docker build


if __name__ == '__main__':
    log.debug('Starting importing dotfiles.')

    if not bool(subprocess.run('groups | grep -q "\\bsudo\b"', shell=True, stdout=subprocess.PIPE).returncode):
        print('Sudo not set. Exit.')
        exit(0)

    setup_before_installation()
    # execute(
    #     'System utils',
    #     via_apt=[
    #         'papirus-icon-theme',
    #         'gnome-tweak-tool',
    #         'gnome-shell-extensions'
    #     ],
    #     via_os=[
    #         'sudo apt update',
    #         'sudo apt upgrade -y',
    #         'sudo add-apt-repository ppa:papirus/papirus',
    #         'sudo apt-get update',
    #         'sudo add-apt-repository universe',
    #         'git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv',
    #         'git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv',
    #     ]
    # )
    setup_libs()
    setup_tmux()
    setup_git()
    _setup_search_tools()
    setup_vim()
    setup_kitty()
    setup_neovim()
    setup_zsh()

    InstalationStatistic.summarize()
