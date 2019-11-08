sudo apt-get update && \
sudo apt-get install vim tmux git exuberant-ctags silversearcher-ag && \
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
~/.fzf/install && \
wget https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb && \
sudo dpkg -i fd_7.4.0_amd64.deb && \
rm fd_7.4.0_amd64.deb && \
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && \
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh && \
ln -s -f ~/.dotfiles/.vimrc ~/.vimrc && \
ln -s -f ~/.dotfiles/.tmux.conf ~/.tmux.conf && \
ln -s -f ~/.dotfiles/.bash_profile ~/.bash_profile && \
ln -s -f ~/.dotfiles/.gitconfig ~/.gitconfig && \
vim +PluginInstall +qall
