sudo apt-get update && \
sudo apt-get install vim tmux git exuberant-ctags silversearcher-ag zsh python-pip && \
chsh -s $(which zsh) && \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions && \
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search && \
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
pip install glances && \
wget https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.zsh -O /usr/local/share/zsh/site-functions/completions.zsh && \
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh && \
source $HOME/.cargo/env && \
cargo install exa && \
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
~/.fzf/install && \
wget https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb -O ~/fd.deb && \
sudo dpkg -i ~/fd.deb && \
rm ~/fd.deb && \
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && \
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh && \
ln -s -f ~/.dotfiles/.vimrc ~/.vimrc && \
ln -s -f ~/.dotfiles/.tmux.conf ~/.tmux.conf && \
ln -s -f ~/.dotfiles/.zshrc ~/.zshrc && \
ln -s -f ~/.dotfiles/.gitconfig ~/.gitconfig && \
vim +PluginInstall +qall
