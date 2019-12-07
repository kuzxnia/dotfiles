#!/usr/bin/env python
from __future__ import print_function

import sys
import os
import shutil
import argparse


def link_files(dotfiles=None):
    if not dotfiles:
        for dotfile in dotfiles:
            execute(f'ln -sf ~/.dotfiles/{dotfile} ~/{dotfile}', msg=f'linking {dotfile}')
    else:
        execute('ln -sf ~/.dotfiles/.* ~/', msg='linking all dotfiles')


def try_to_install(*libs):
    for lib in libs:
        print(f'trying to install {lib}')
        execute('sudo apt-get install {0} || pip install {0} || sudo pip install {0}'.format(lib))


def execute(*commands, msg=None):
    print(msg or f'running: {commands}')
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
        'vim',
        'tmux',
        'tree',
        'exuberant-ctags',
        'silversearcher-ag',
        'python-pip',
        'flake8',
    )


def setup_extra_libs():
    '''not nessesary for pair-programming porpouses'''
    try_to_install(
        'glances',
        'htop',
    )
    execute(
        "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh",
        'source $HOME/.cargo/env',
        'cargo install exa',
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


def backup():
    files_to_dump = [
        os.path.join(dirpath, filename)
        for dirpath, dirnames, filenames in os.walk('.')
        for filename in filenames
        if filename in ['.bashrc', '.bash_profile', '.vimrc', '.tmux.conf', '.zshrc']
    ]

    for f in files_to_dump:
        shutil.copy(f, f + '.bak')


def pair_programming_setup():
    backup()
    execute('sudo apt-get update')
    setup_libs()
    setup_IDE()


def full_setup():
    pair_programming_setup()
    setup_extra_libs()
    setup_shell()


def restore_files():
    print('This function is not ready yet')
    # TODO
    pass


def main():
    parser = argparse.ArgumentParser(description='Workflow env importer', argument_default='help')
    parser.add_argument(
        '--setup',
        choices=['pair_programming', 'full', 'backup_dotfiles', 'restore_dotfiles'],
        help='Choose what you want to setup'
    )

    if len(sys.argv) < 2:
        parser.print_help()
        sys.exit(1)

    args = parser.parse_args()

    arg_function = {
        'pair_programming': pair_programming_setup,
        'full': full_setup,
        'restore_dotfiles': restore_files,
        'backup_dotfiles': backup,
    }

    arg_function[args.setup]()


if __name__ == '__main__':
    # TODO: init working env, env wrapper, tox
    main()
