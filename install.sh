if [ ! -d '~/.dotfiles' ] 
then
    git clone https://github.com/kuzxnia/dotfiles.git ~/.dotfiles
fi;
python ~/.dotfiles/install.py
