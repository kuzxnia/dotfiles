<h3 align="center">
  <span><img width="18" src="https://image.flaticon.com/icons/svg/226/226772.svg" alt="Linux - Icon made by Freepik from Flaticon" /></span>
  kuzxnia/dotfiles
  <span><img alt="Travis CI" src="https://travis-ci.com/kuzxnia/dotfiles.svg?branch=master"></span>
</h3>

<h3 align="center">
    <img alt="Installation process" src="https://github.com/kuzxnia/dotfiles/blob/master/demo/installation.gif">
</h3>

<p align="center">
<a href='#install'>How to</a> • <a href='#components'>What's inside</a> • <a href='#testing'>Testing</a> • <a href='#license'>License</a>
</p>

## <a name='approach'>:star: Approach </a>
There is a `manage.py` setup script which run as installation process.

## <a name='install'>:rocket: Installation</a>

```bash
# using curl
curl -sSL https://raw.githubusercontent.com/kuzxnia/dotfiles/master/manage.py | python3

# using wget
python3 -c "$(wget -O - https://raw.githubusercontent.com/kuzxnia/dotfiles/master/manage.py)"

# or if you have clonned repository
python3 manage.py
```

## <a name='components'>:postbox: What's in the box?</a>

<h4><span><img width="80" src="https://github.com/kuzxnia/dotfiles/blob/master/demo/neovim.png"/></span></h4>

I loved my <span><img width="14" src="https://github.com/kuzxnia/dotfiles/blob/master/demo/vim.svg"/></span>. It was fast and enjoyable. But I have switched to `NeoVim`. The main reason is that `Vim` is slowly maintained and async support is not best. `NeoVim` is the future :smile:.
Here's how my new setup looks like:

<h3 align="center">
    <img alt="NeoVim setup" src="https://github.com/kuzxnia/dotfiles/blob/master/demo/nvim.gif" style="width: 700px">
</h3>

#### NeoVim shortcuts

* git messenger:
    * open commit info <kbd>,</kbd>+<kbd>g</kbd>+<kbd>m</kbd>
* ale:
    * next issue <kbd>]</kbd>+<kbd>w</kbd>
    * previous issue <kbd>[</kbd>+<kbd>w</kbd>
    * auto fix <kbd>,</kbd>+<kbd>f</kbd>
* jedi, deoplete:
    * go to command <kbd>,</kbd>+<kbd>d</kbd>
    * go to assignments <kbd>,</kbd>+<kbd>d</kbd>
    * show documentation <kbd>K</kbd>
    * show usages <kbd>,</kbd>+<kbd>u</kbd>
    * command completions <kbd>ctrl</kbd>+<kbd>space</kbd>
    * rename command <kbd>,</kbd>+<kbd>r</kbd>
    * up in popup <kbd>ctrl</kbd>+<kbd>k</kbd>
    * down in popup <kbd>ctrl</kbd>+<kbd>j</kbd>
* nerdtree:
    * open/toggle <kbd>,</kbd>+<kbd>n</kbd>+<kbd>n</kbd>
    * find open file <kbd>,</kbd>+<kbd>n</kbd>+<kbd>f</kbd>
    * open mirror (usefull with multiple tabs) <kbd>,</kbd>+<kbd>n</kbd>+<kbd>m</kbd>
* fzf, ripgrep, buffers:
    * fuzzy file search <kbd>ctrl</kbd>+<kbd>f</kbd>
    * fuzzy grep search <kbd>ctrl</kbd>+<kbd>g</kbd>
    * open file in new tab <kbd>ctrl</kbd>+<kbd>t</kbd>
    * open file in vertical split <kbd>ctrl</kbd>+<kbd>v</kbd>
    * open file in horizontal split <kbd>ctrl</kbd>+<kbd>x</kbd>
    * open buffers <kbd>F11</kbd>
    * last buffers <kbd>F12</kbd>
* split panels:
    * move to left panel <kbd>,</kbd>+<kbd>h</kbd>
    * move to right panel <kbd>,</kbd>+<kbd>l</kbd>
    * move to upper panel <kbd>,</kbd>+<kbd>k</kbd>
    * move to lower panel <kbd>,</kbd>+<kbd>j</kbd>
* else:
    * syntax sync <kbd>F5</kbd>
    * remove trailing spaces <kbd>F6</kbd>
    * set paste/nopaste <kbd>F8</kbd>
    * retab <kbd>F10</kbd>
    * open neovim configuration <kbd>,</kbd>+<kbd>v</kbd>

#### tmux

* split panels
    * open sessions tree <kbd>ctrl</kbd><kbd>a</kbd>+<kbd>s</kbd>
    * move to left panel <kbd>alt</kbd>+<kbd>h</kbd>
    * move to right panel <kbd>alt</kbd>+<kbd>l</kbd>
    * move to upper panel <kbd>alt</kbd>+<kbd>k</kbd>
    * move to lower panel <kbd>alt</kbd>+<kbd>j</kbd>

#### command line (zsh, fzf)

* recent commands:
    * command completions <kbd>ctrl</kbd>+<kbd>space</kbd>
    * previous command <kbd>ctrl</kbd>+<kbd>k</kbd>
    * next command <kbd>ctrl</kbd>+<kbd>j</kbd>
    * insert sudo before command <kbd>ESC</kbd>+<kbd>ESC</kbd>
    * last command fuzzy search <kbd>ctrl</kbd>+<kbd>r</kbd>


## <a name='testing'>:ok_hand: Testing</a>
In an attempt to ensure that this dotfiles setup will always work on a brand new, clean machine. I use the docker image in this repository to apply this repository to a clean Ubuntu 19.10 container.

## <a name='license'>:stop_sign: License</a>
<span><a href="http://www.wtfpl.net/"><img src="http://www.wtfpl.net/wp-content/uploads/2012/12/wtfpl-badge-4.png" width="80" height="15" alt="WTFPL" /></a><span> Like the license said. :stuck_out_tongue_closed_eyes:
