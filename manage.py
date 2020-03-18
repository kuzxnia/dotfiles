#!/usr/bin/env python
from __future__ import print_function

import sys
import os


def full_setup():
    execute(
        'sudo apt update',
        'sudo apt upgrade -y',
        'sudo add-apt-repository ppa:papirus/papirus',
        'sudo apt-get update',
        'sudo apt-get install papirus-icon-theme',
        'git clone https://github.com/pyenv/pyenv.git ~/.pyenv',
        'git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv',
    )
    setup_git()

    setup_IDE()

    setup_rust()
    setup_external_libs()


def setup_IDE():
    setup_libs()
    setup_vim()
    setup_neovim()
    _setup_search_tools()
    setup_tmux()
    setup_kitty()
    setup_zsh()


def setup_vim():
    try_to_install('vim')
    link_files(['.vimrc'])
    execute('git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim')


def setup_neovim():
    execute('mkdir ~/.config/nvim')
    link_files(['.config/init.vim'])
    execute(
        'sudo add-apt-repository ppa:neovim-ppa/unstable',
        'sudo apt-get update',
        'sudo apt-get install neovim',
        'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
        'pip install pynvim',
        'pip3 install pynvim'
    )


def _setup_search_tools():
    if not os.path.exists('~/.fzf'):
        execute(
            'git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf',
            '~/.fzf/install',
            msg='installing fzf'
        )

    execute(
        'wget https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb -O ~/fd.deb',
        'sudo dpkg -i ~/fd.deb',
        msg='installing fd'
    )
    execute(
        'wget https://github.com/gsamokovarov/jump/releases/download/v0.23.0/jump_0.23.0_amd64.deb -O ~/jump.deb',
        'sudo dpkg -i ~/jump.deb',
        msg='installing jump'
    )


def setup_tmux():
    try_to_install('tmux')
    link_files(['.tmux.conf'])
    execute('git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm')


def setup_git():
    try_to_install('git')
    link_files(['.gitconfig'])
    execute(
        'wget https://github.com/dandavison/delta/releases/download/0.0.15/git-delta_0.0.15_amd64.deb -O ~/delta.deb',
        'sudo dpkg -i ~/delta.deb'
    )


def setup_libs():
    try_to_install(
        'tree',
        'exuberant-ctags',
        'silversearcher-ag',
        'python-pip',
        'python3-pip',
        'flake8',
        'curl',
        'pipenv'
    )


def setup_kitty():
    execute('mkdir ~/.config/kitt', 'curl -o ~/.config/kitty/snazzy.conf https://raw.githubusercontent.com/connorholyday/kitty-snazzy/master/snazzy.conf')
    link_files(['.config/kitty/kitty.conf'])
    try_to_install('kitty')


def setup_rust():
    execute(
        "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh",
        'source $HOME/.cargo/env',
        msg='installing cargo'
    )


def setup_external_libs():
    '''not nessesary for pair-programming porpouses'''
    try_to_install(
        'glances',
        'htop',
        'ranger',
        'highlight',
    )
    execute(
        'cargo install exa',
        msg='installing cargo'
    )


def setup_zsh():
    try_to_install('zsh')
    execute('sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"', 'installing oh-my-zsh')
    execute(
        'git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions',
        'git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search',
        'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting',
        'chsh -s $(which zsh)',
        msg='fetching/installing zsh plugins'
    )
    link_files(['.zshrc'])


def link_files(dotfiles=None):
    for dotfile in dotfiles:
        execute(f'ln -sf ~/.dotfiles/{dotfile} ~/{dotfile}', msg=f'linking {dotfile}')


def try_to_install(*libs):
    for lib in libs:
        print(f'trying to install {lib}')
        execute('sudo apt-get install {0} || pip install {0} || sudo pip install {0}'.format(lib))


def execute(*commands, msg=None):
    print(msg or f'running: {commands}')
    for command in commands:
        os.system(command)


if __name__ == '__main__':
    from pprint import pformat
    setups = [x[6:] for x in globals().keys() if x.startswith('setup_')]

    if not len(sys.argv[1:]):
        print(
            (
                f'Welcome in workflow importer!!!\n'
                f'Choose what you want to install: {pformat(setups)}'
            )
        )
        sys.exit(1)

    for arg in sys.argv[1:]:
        if arg in setups:
            globals().get(f'setup_{arg}')()
