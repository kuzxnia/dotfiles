#!/usr/bin/env python3
from __future__ import print_function

import sys
import os
import shlex
import subprocess
from getpass import getpass


def setup_before_installation():
    execute(
        'Basic utilities',
        via_apt=[
            'git',
            'python-pip',
            'python3-pip',
            'curl',
        ],
        via_pip=['progress'],
        via_os=['git clone https://github.com/kuzxnia/dotfiles.git ~/.dotfiles']
    )


def setup_vim():
    execute(
        'Vim',
        via_apt=['vim'],
        via_os=['git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim'],
        link_files=['.vimrc']
    )


def setup_neovim():
    execute(
        'Neovim',
        via_os=[
            'sudo add-apt-repository ppa:neovim-ppa/unstable',
            'sudo apt-get update',
            'sudo apt-get install neovim',
            'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
            'pip install pynvim',
            'pip3 install pynvim'
        ],
        link_files=['.config/nvim/init.vim']
    )


def _setup_search_tools():
    execute(
        'Search utilities',
        via_apt=['bat', 'ripgrep'],
        via_os=[
            ('git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf', '~/.fzf/install --all',)
            ('wget https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb -O ~/fd.deb', 'sudo dpkg -i ~/fd.deb',)
            ('wget https://github.com/gsamokovarov/jump/releases/download/v0.23.0/jump_0.23.0_amd64.deb -O ~/jump.deb', 'sudo dpkg -i ~/jump.deb',)
        ]
    )


def setup_tmux():
    execute(
        'tmux',
        via_apt=['tmux'],
        via_os=[
            (lambda: not os.path.exists('~/.tmux/plugins/tpm'), 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm', '$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh')
        ],
        link_files=['.tmux.conf']
    )


def setup_git():
    execute(
        'git',
        via_os=[
            (lambda: True, 'wget https://github.com/dandavison/delta/releases/download/0.0.15/git-delta_0.0.15_amd64.deb -O ~/delta.deb', 'sudo dpkg -i ~/delta.deb')
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
            'glances',
            'htop',
            'ranger',
            'highlight',
        ],
        via_os=[
            (lambda: not check_installed('exa'), 'wget -c https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip', 'unzip exa-linux-x86_64-0.9.0.zip', 'sudo mv exa-linux-x86_64 /usr/local/bin/exa'),
            (lambda: True, 'wget -q https://github.com/jarun/googler/releases/download/v4.0/googler_4.0-1_ubuntu18.04.amd64.deb -O ~/googler.deb', 'sudo dpkg -i ~/googler.deb')
        ]
    )


def setup_kitty():
    execute(
        'Kitty',
        via_apt=['kitty'],
        via_os=['curl -o ~/.config/kitty/snazzy.conf https://raw.githubusercontent.com/connorholyday/kitty-snazzy/master/snazzy.conf'],
        link_files=['.config/kitty/kitty.conf']
    )


def setup_zsh():
    execute(
        'Zsh',
        via_apt=['zsh'],
        via_os=[
            (lambda: os.path.exists('~/.oh-my-zsh'), 'sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"<<"exit"'),
            'git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions',
            'git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search',
            'git clone https://github.com/zdharma/fast-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting',
            'chsh -s $(which zsh)',
            'ln -sf ~/.dotfiles/.zsh/themes/raw.zsh-theme ~/.oh-my-zsh/themes/raw.zsh-theme',
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
    via_pip = via_pip or []
    link_files = link_files or []

    bar_len = len(via_apt) + len(via_pip) + len(via_os) + len(link_files)

    bar = IncrementalBar(msg, max=bar_len)
    bar.start()

    if is_sudo:
        for command in via_apt:
            if not check_apt_installed(command):
                subprocess.run(f'sudo apt-get install -y {command}', shell=True, stdout=subprocess.PIPE)
            bar.next()

    for command in via_pip:
        subprocess.run('yes | pip3 install {0}; yes | sudo pip3 install {0}'.format(command), shell=True, stdout=subprocess.PIPE)
        bar.next()

    for command in via_os:
        if isinstance(command, tuple):
            contition, *commands = command
            if contition():
                for command in commands:
                    subprocess.run(command, shell=True, stdout=subprocess.PIPE)

        else:
            subprocess.run(command, shell=True, stdout=subprocess.PIPE)
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
    setup_libs()
    # setup_vim()
    # setup_neovim()
    # _setup_search_tools()
    # setup_tmux()
    # setup_kitty()
    # setup_zsh()
