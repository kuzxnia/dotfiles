<h3 align="center">
  <span><img width="18" src="https://image.flaticon.com/icons/svg/226/226772.svg" alt="Linux - Icon made by Freepik from Flaticon" /></span>
  kuzxnia/dotfiles
  <span><img alt="Travis CI" src="https://img.shields.io/travis/kuzxnia/dotfiles"></span>
</h3>


# :star: Approach
There is a `manage.py` setup script which run as installation process.

# :rocket: Installation

```bash
python3 -c "$(wget https://raw.githubusercontent.com/kuzxnia/dotfiles/master/manage.py -O)"

# or if you have clonned repository
python3 manage.py
```

# :postbox: What's in the box?
* zsh
* vim and neovim
* tmux
* kitty
* fzf and ripgrep


# :ok_hand: Testing
In an attempt to ensure that this dotfiles setup will always work on a brand new, clean machine. I use the docker image in this repository to apply this repository to a clean Ubuntu 19.10 container.
