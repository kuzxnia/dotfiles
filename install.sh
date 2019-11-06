sudo apt-get update && \
sudo apt-get install vim tmux git exuberant-ctags silversearcher-ag && \
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
~/.fzf/install && \
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && \
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh && \
ln -s -f ~/.dotfiles/.vimrc ~/.vimrc && \
ln -s -f ~/.dotfiles/.tmux.conf ~/.tmux.conf && \
ln -s -f ~/.dotfiles/.bash_profile ~/.bash_profile && \
ln -s -f ~/.dotfiles/.gitconfig ~/.gitconfig && \
vim +PluginInstall +qall
