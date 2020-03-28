<h3 align="center">
  <span><img width="18" src="https://image.flaticon.com/icons/svg/226/226772.svg" alt="Linux - Icon made by Freepik from Flaticon" /></span>
  kuzxnia/dotfiles
  <span><img alt="Travis CI" src="https://travis-ci.com/kuzxnia/dotfiles.svg?branch=master"></span>
</h3>


# :star: Approach
There is a `manage.py` setup script which run as installation process.

# :rocket: Installation

```bash
# using curl
curl -sSL https://raw.githubusercontent.com/kuzxnia/dotfiles/master/manage.py | python3

# using wget
python3 -c "$(wget -O - https://raw.githubusercontent.com/kuzxnia/dotfiles/master/manage.py)"

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
