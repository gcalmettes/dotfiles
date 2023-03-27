# Dotfiles

## Sway
- build/install `sway` stack (`https://github.com/luispabon/sway-ubuntu`)
- additional builds (`meson build && ninja -C build && ninja -C build install`)
  - [swaybg](https://github.com/swaywm/swaybg)
  - [swayidle](https://github.com/swaywm/swayidle)
  - [grim](https://git.sr.ht/~emersion/grim)
  - [slurp](https://github.com/emersion/slurp)
- `swaylock` (`sudo apt install swaylock`)
- `ulauncher` (`sudo add-apt-repository ppa:agornostal/ulauncher && sudo apt update && sudo apt install ulauncher`) as application launcher
- `pavucontrol` (`sudo apt install pavucontrol`) called in `waybar` config
- managed by `pipx` (see below):
  - [`flashfocus`](https://github.com/fennerm/flashfocus)
  - [`autotiling`](https://github.com/nwg-piotr/autotiling)

## AppImages

AppImages require FUSE version 2 to run ([wiki](https://github.com/AppImage/AppImageKit/wiki/FUSE))

`sudo apt install libfuse2`

## Shell & binaries

- `zsh` (`sudo apt install zsh -y`)
  - set `zsh` as default shell (`chsh -s /usr/bin/zsh`)
- [`starship`](https://github.com/starship/starship) as prompt
- `wl-copy` (`sudo apt install wl-clipboard`) called in scripts
- `neovim` as default editor. For neovim plugins:
  - `vale` (`https://github.com/errata-ai/vale/releases`) for [`null-ls`](https://github.com/jose-elias-alvarez/null-ls.nvim)
  - `ripgrep` (`sudo apt install ripgrep`) for [`telescope`](https://github.com/nvim-telescope/telescope.nvim)
  - LSP:
    - `pyright` (managed by `pipx`, see below)
    - `rust-analyzer`
      ```
      curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/bin/rust-analyzer
      chmod +x ~/bin/rust-analyzer
      ```
    - `tflint`
      ```
      curl -L https://github.com/terraform-linters/tflint/releases/latest/download/tflint_linux_amd64.zip | gunzip -c - > ~/bin/tflint
      chmod +x ~/bin/tflint
      ```
- [`delta`](https://github.com/dandavison/delta) to be used by `git diff` (see `~/.gitconfig`)
- [`exa`](https://github.com/ogham/exa) as replacement of `ls`
- [`bottom`](https://github.com/ClementTsang/bottom) as replacement of `top/htop`
- [`dust`](https://github.com/bootandy/dust) as replacement of `du`
- [`bat`](https://github.com/sharkdp/bat) as replacement of `cat`


### Utils

- [`direnv`](https://github.com/direnv/direnv)
- [`asdf`](https://github.com/asdf-vm/asdf)
  - plugins:
    - [`direnv`](https://github.com/asdf-community/asdf-direnv)
    - [`python`](https://github.com/asdf-community/asdf-python)
    - [`nodejs`](https://github.com/asdf-vm/asdf-nodejs)
    - [`golang`](https://github.com/kennyp/asdf-golang)
- `tree` (`sudo apt install tree`)
- `vlc` (`sudo apt install vlc`)
- `ssh-askpass` (`sudo apt install ssh-askpass`), required for ssh agent setup (see `~/.zshrc`)
- [`pipx`](https://github.com/pypa/pipx) to manage:
  - [`git-cu`](https://gitlab.com/3point2/git-cu)
  - [`flashfocus`](https://github.com/fennerm/flashfocus)
  - [`autotiling`](https://github.com/nwg-piotr/autotiling)
  - [`pyright`](https://github.com/microsoft/pyright) for `nvim` LSP
- [`obsidian`](https://github.com/obsidianmd/obsidian-releases) as documentation manager
- `openvpn3` (requires `sudo apt install apt-transport-https` first)
- kubernetes/cloud ecosystem (`kubectl`/`helm`/`terraform`)

