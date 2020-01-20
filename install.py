#!/usr/bin/env python
from __future__ import print_function

import sys
import os


def setup_vim():
    link_files(['.vimrc'])
    execute(
        'git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim',
        'vim +PluginInstall +qall',
    )

    if not os.path.isdir('~/.fzf'):
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
    link_files(['.tmux.conf'])
    execute('git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm')


def setup_git():
    link_files(['.gitconfig'])
    execute(
        'wget https://github.com/dandavison/delta/releases/download/0.0.15/git-delta_0.0.15_amd64.deb -O ~/delta.deb',
        'sudo dpkg -i ~/delta.deb'
    )



def setup_libs():
    try_to_install(
        'vim',
        'tmux',
        'tree',
        'exuberant-ctags',
        'silversearcher-ag',
        'python-pip',
        'python3-pip',
        'flake8',
        'curl'
    )


def setup_rust():
    execute(
        "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh",
        'source $HOME/.cargo/env',
        msg='installing cargo'
    )


def setup_ext_libs():
    '''not nessesary for pair-programming porpouses'''
    try_to_install(
        'glances',
        'htop',
        'ranger',
        'highlight',
    )
    execute('ln -sf ~/.dotfiles/rc.conf ~/.config/ranger/rc.conf')
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


def main():
    setups = [x[6:] for x in globals().keys() if x.startswith('setup_')]

    if not len(sys.argv[1:]):
        print((
            f'Welcome in env importer!!!\n' +
            f'Choose what you want to install: [{setups}]'
        ))
        sys.exit(1)

    for arg in sys.argv[1:]:
        if arg in setups:
            globals().get(f'setup_{arg}')()


if __name__ == '__main__':
    # TODO: init working env, env wrapper, tox
    # TODO: not to link .git, not rm fd, jump after succesefull intall
    # TODO: setup pp, shell,
    main()
