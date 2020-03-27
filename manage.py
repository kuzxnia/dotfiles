#!/usr/bin/env python3
from __future__ import print_function

import os
import subprocess


def setup_before_installation():
    execute(
        'Basic utilities',
        via_apt=[
            'git',
            'python-pip',
            'python3-pip',
            'curl',
            'wget'
        ],
        via_pip=['progress'],
        via_os=['git clone https://github.com/kuzxnia/dotfiles.git $HOME/.dotfiles']
    )


def setup_vim():
    execute(
        'Vim',
        via_apt=['vim'],
        via_os=['git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim'],
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
                lambda: not os.path.exists('$HOME/.fzf'),
                'git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf',
                '$HOME/.fzf/install --all'
            ),
            (
                lambda: not check_installed('fd'),
                'wget -q https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb -O $HOME/fd.deb',
                'sudo dpkg -i $HOME/fd.deb'
            ),
            (
                lambda: not check_installed('jump'),
                'wget -q https://github.com/gsamokovarov/jump/releases/download/v0.23.0/jump_0.23.0_amd64.deb -O $HOME/jump.deb',
                'sudo dpkg -i $HOME/jump.deb'
            )
        ]
    )


def setup_tmux():
    execute(
        'tmux',
        via_apt=['tmux'],
        via_os=[
            (
                lambda: not os.path.exists('$HOME/.tmux/plugins/tpm'),
                'git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm',
                'tmux source-file ~/.tmux.conf',
                '$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh'
            )
        ],
        link_files=['.tmux.conf']
    )


def setup_git():
    execute(
        'git',
        via_os=[
            (
                lambda: True,
                'wget -q https://github.com/dandavison/delta/releases/download/0.0.15/git-delta_0.0.15_amd64.deb -O $HOME/delta.deb',
                'sudo dpkg -i $HOME/delta.deb'
            )
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
                lambda: not check_installed('exa'),
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
                lambda: os.path.exists('~/.oh-my-zsh'),
                'sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"<<"exit"'
            ),
            'git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions',
            'git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search',
            'git clone https://github.com/zdharma/fast-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting',
            'chsh -s $(which zsh)'
            # 'ln -sf ~/.dotfiles/.zsh/themes/raw.zsh-theme ~/.oh-my-zsh/themes/raw.zsh-theme',
        ],
        link_files=[
            '.zshrc'
            '.zsh/abbreviations.zsh'
        ]
    )


def check_installed(command):
    return not bool(subprocess.run(command, shell=True, stdout=subprocess.PIPE).returncode)


def check_apt_installed(package):
    return not bool(subprocess.run('dpkg --get-selections | grep -q "^%s*[[:space:]]*install$"' % package, shell=True, stdout=subprocess.PIPE).returncode)


def is_sudo():
    return not bool(subprocess.run('groups | grep -q "\\bsudo\b"', shell=True, stdout=subprocess.PIPE).returncode)


def execute(msg, via_apt=None, via_pip=None, via_os=None, link_files=None):
    from progress.bar import IncrementalBar

    via_apt = via_apt or []
    via_pip = via_pip or []
    via_os = via_os or []
    link_files = link_files or []

    bar_len = len(via_apt) + len(via_pip) + len(via_os) + len(link_files)

    bar = IncrementalBar(msg, max=bar_len)
    bar.start()

    if is_sudo:
        for command in via_apt:
            if not check_apt_installed(command):
                print('running %s', command)
                output = subprocess.run(f'sudo apt-get install -y {command}', shell=True, stdout=subprocess.PIPE)
                if output.returncode != 0:
                    print('%s output\n %r', command, output)
                else:
                    print('%s installed sucessfuly', command)

            bar.next()

    for command in via_pip:
        print('running %s', command)
        output = subprocess.run('yes | pip3 install {0}; yes | sudo pip3 install {0}'.format(command), shell=True, stdout=subprocess.PIPE)
        if output.returncode != 0:
            print('%s output\n %r', command, output)
        else:
            print('%s installed sucessfuly', command)
        bar.next()

    for command in via_os:
        if isinstance(command, tuple):
            contition, *commands = command
            if contition():
                for command in commands:
                    print('running %s', command)
                    output = subprocess.run(command, shell=True, stdout=subprocess.PIPE)
                    if output.returncode != 0:
                        print('%s output\n %r', command, output)
                    else:
                        print('%s installed sucessfuly', command)

        else:
            print('running %s', command)
            output = subprocess.run(command, shell=True, stdout=subprocess.PIPE)
            if output.returncode != 0:
                print('%s output\n %r', command, output)
            else:
                print('%s installed sucessfuly', command)
        bar.next()

    home = os.path.expanduser('~')
    for path in link_files:
        dest = os.path.join(home, path)
        path = os.path.join(home, f'.dotfiles/{path}')

        os.makedirs(os.path.dirname(dest), exist_ok=True)
        os.symlink(path, dest)
        bar.next()

    bar.finish()


if __name__ == '__main__':
    # dodawanie statystyk ilosc zainstalowanych, pominietych, nieudanych
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
    #         'git clone https://github.com/pyenv/pyenv.git ~/.pyenv',
    #         'git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv',
    #     ]
    # )
    print('rozpoczynam instalacje')
    setup_before_installation()
    setup_libs()
    setup_tmux()
    setup_git()
    _setup_search_tools()
    setup_vim()
    setup_neovim()
    setup_kitty()
    setup_zsh()
