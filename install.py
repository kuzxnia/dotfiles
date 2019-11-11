#!/usr/bin/env python
from __future__ import print_function

import os
import sys


def link_files(dotfiles=None):
    # *dotfiles
    if not dotfiles:
        for dotfile in dotfiles:
            execute('ln -sf ~/.dotfiles/{} ~/{}'.format(dotfile), msg='linking %s' % dotfile)
    else:
        execute('ln -sf ~/.dotfiles/.* ~/', msg='linking all dotfiles from ')


def try_to_install(*libs):
    for lib in libs:
        print('trying to install %s' % lib)
        execute('sudo apt-get install {} || pip install {} || sudo pip install {}'.format(lib))


def execute(*commands, msg=None):
    print(msg or 'running: %s' % commands)
    for command in commands:
        os.system(command)


def setup_IDE():
    link_files(['.vimrc', '.tmux.conf', '.bash_profile'])
    execute(
        'git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim',
        'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm',
        'vim +PluginInstall +qall',
    )

    if not os.path.isdir('~/fzf'):
        execute('git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf', '~/.fzf/install', msg='installing fzf')

    execute(
        'fd --version || wget https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb -O ~/fd.deb && sudo dpkg -i ~/fd.deb && rm ~/fd.deb',
        msg='installing fd'
    )
    execute(
        'wget https://github.com/gsamokovarov/jump/releases/download/v0.23.0/jump_0.23.0_amd64.deb -O ~/jump.deb && sudo dpkg -i ~/jump.deb && rm ~/jump.deb',
        msg='installing jump'
    )


def setup_libs():
    try_to_install(
        'git',
        'vim',
        'tmux',
        'git',
        'tree',
        'exuberant-ctags',
        'silversearcher-ag',
        'python-pip',
    )


def setup_extra_libs():
    '''not nessesary for pair-programming porpouses'''
    try_to_install([
        'glances',
        'htop',
    ])
    # jump
    execute(
        [
            "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh",
            'source $HOME/.cargo/env',
            'cargo install exa', 
        ],
        msg='installing cargo and exa'
    )



def setup_shell():
    try_to_install('zsh')
    execute('sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"', 'installing oh-my-zsh')
    execute(
        'git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions',
        'git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search',
        'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting',
        'chsh -s $(which zsh)',
        msg='fetching/installing zsh plugins'
    )

def files_to_backup():
    files_to_dump = ('.bashrc', '.bash_profile', '.vimrc', '.tmux.conf', '.zshrc')

    return [
        os.path.join(dirpath, filename)
        for dirpath, dirnames, filenames in os.walk('.', followlinks=True)
        for filename in filenames
        if filename in files_to_dump
    ]

def pair_programming_setup():
    # TODO: backup
    execute('sudo apt-get update')
    setup_libs()
    setup_IDE()



def full_setup():
    pair_programming_setup()
    setup_extra_libs()
    setup_shell()


if __name__ == '__main__':
    # also dump existing files, restore after pp
    # TODO: 2. full setup akka, init working env
    main()
