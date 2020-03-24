#!/usr/bin/env python3
from __future__ import print_function

import sys
import os
import shlex
import subprocess
from getpass import getpass

password = None


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


def full_setup():
    execute(
        'System utils',
        via_apt=[
            'papirus-icon-theme',
            'gnome-tweak-tool',
            'gnome-shell-extensions'
        ],
        via_os=[
            'sudo apt update',
            'sudo apt upgrade -y',
            'sudo add-apt-repository ppa:papirus/papirus',
            'sudo apt-get update',
            'sudo add-apt-repository universe',
            'git clone https://github.com/pyenv/pyenv.git ~/.pyenv',
            'git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv',
        ]
    )
    setup_IDE()


def setup_IDE():
    setup_libs()
    setup_vim()
    setup_neovim()
    _setup_search_tools()
    setup_tmux()
    setup_kitty()
    setup_zsh()


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
        link_files=['.config/init.vim']
    )


def _setup_search_tools():
    execute(
        'Search utilities',
        via_apt=['bat', 'ripgrep'],
        via_os=[
            'git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf',
            '~/.fzf/install --all',
            'wget https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb -O ~/fd.deb',
            'sudo dpkg -i ~/fd.deb',
            'wget https://github.com/gsamokovarov/jump/releases/download/v0.23.0/jump_0.23.0_amd64.deb -O ~/jump.deb',
            'sudo dpkg -i ~/jump.deb',
        ]
    )


def setup_tmux():
    execute(
        'tmux',
        via_apt=['tmux'],
        via_os=['git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm'],
        link_files=['.tmux.conf']
    )


def setup_git():
    execute(
        'git',
        via_os=[
            'wget https://github.com/dandavison/delta/releases/download/0.0.15/git-delta_0.0.15_amd64.deb -O ~/delta.deb',
            'sudo dpkg -i ~/delta.deb'
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
            'wget -c https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip',
            'unzip exa-linux-x86_64-0.9.0.zip',
            'sudo mv exa-linux-x86_64 /usr/local/bin/exa',
            'wget https://github.com/jarun/googler/releases/download/v4.0/googler_4.0-1_ubuntu18.04.amd64.deb -O ~/googler.deb',
            'sudo dpkg -i ~/googler.deb'
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
            'sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"',
            'git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions',
            'git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search',
            'git clone https://github.com/zdharma/fast-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting',
            'git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh}/themes/spaceship-prompt',
            'chsh -s $(which zsh)',
            'ln -sf ~/.dotfiles/.zsh/themes/raw.zsh-theme ~/.oh-my-zsh/themes/',
        ],
        link_files=[
            '.zshrc'
            '.zsh/abbreviations.zsh'
        ]
    )


def execute(msg, via_apt=None, via_pip=None, via_os=None, link_files=None):
    from progress.bar import IncrementalBar
    import pexpect

    via_apt = via_apt or []
    via_pip = via_pip or []
    via_pip = via_pip or []
    link_files = link_files or []

    bar_len = len(via_apt) + len(via_pip) + len(via_os) + len(link_files)

    commands = [
        f'sudo apt-get install -y {command}'
        for command in via_apt
    ]
    commands += [
        'yes | pip3 install {0} || yes | sudo pip3 install {0}'.format(command)
        for command in via_pip
    ]
    commands += via_os
    commands += [
        f'ln -sf $HOME/.dotfiles/{dotfile} $HOME/{dotfile}'
        for dotfile in link_files
    ]

    bar = IncrementalBar(msg, max=bar_len)
    bar.start()

    for command in commands:
        child = pexpect.spawn(command)
        if child.expect([pexpect.TIMEOUT, 'password', pexpect.EOF]):
            child.sendline(password)
        child.read()
        bar.next()

    for path in link_files:
        os.symlink(f'$HOME/.dotfiles/{path}', f'$HOME/{path}')
        bar.next()

    bar.finish()


if __name__ == '__main__':
    global password
    setups = [x[6:] for x in globals().keys() if x.startswith('setup_')]

    if not len(sys.argv[1:]):
        print(
            (
                f'Welcome in workflow importer!!!\n'
                f'Choose what you want to install:\n {", ".join(setups)}'
            )
        )
        sys.exit(1)

    for arg in sys.argv[1:]:
        password = getpass('[sudo] password for user: ')
        if arg in setups:
            globals().get(f'setup_{arg}')()
