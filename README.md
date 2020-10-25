# dotfiles

Based on https://www.freecodecamp.org/news/a-guide-to-modern-web-development-with-neo-vim-333f7efbf8e2/

# SHELL

## Install powerline fonts (https://github.com/powerline/fonts)
```
sudo apt install fonts-powerline
```

## Install zsh
```
sudo apt install zsh
```

## Install Oh-my-Zsh (https://github.com/ohmyzsh/ohmyzsh)
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Use autocompletion hints (https://github.com/zsh-users/zsh-autosuggestionsi)
```
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
```

## Spaceship prompt (https://github.com/denysdovhan/spaceship-prompt)
```
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1

ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" 
```

## Grep on steroids (https://github.com/BurntSushi/ripgrep)
```
sudo apt install ripgrep
```

## Fuzzy Finder command line (https://github.com/junegunn/fzf)
```
sudo apt install fzf
```

# PROGRAMS

## Install Node Version Manager (https://github.com/nvm-sh/nvm)
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
```

## Install Ruby Version Manager with latest ruby
```
curl -sSL https://get.rvm.io | bash -s stable --ruby
```

### Set latest ruby as default
```
rvm list # (to get ruby installed, e.g.: ruby-2.7.0)
rvm --default use 2.7.0
```

## ls on steroids (https://github.com/athityakumar/colorls)
```
gem install colorls
```

## Install tmux
```
sudo apt install tmux
```

## Install tmux plugin manager
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Install neovim (https://github.com/neovim/neovim)
```
sudo apt update neovim
```

## Intellisense in neovim (https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions)
```
:CocInstall coc-json coc-tsserver coc-python coc-yaml coc-go coc-css coc-html coc-jedi
```

## Move space config
```
cp ~/.config/nvim/space.vim ~/.config/nvim/plugged/vim-airline-themes/autoload/airline/themes/space.vim
```


# TIPS

## Neovim

| Command  |     Action                                                                   |
|----------|:----------------------------------------------------------------------------:|
| `;`      |  Brings up all opened buffers. Then `Ctrl-o` to be like in normal mode       |
| `,t`     |  Fuzzy find files in current folder. Then `Ctrl-o` to be like in normal mode |
| `,g`     |  Search the entire project for a given term. Then `Ctrl-o` to be like in normal mode |
| `,j`     |  Search the term under cursor. Then `Ctrl-o` to be like in normal mode |
| `,nn`    |  brings up NerdTree                                                          |
    
