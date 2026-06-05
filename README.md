# dotfiles_macos
Repo for dotfiles on my personal Macbook Pro, using GNU Stow. 

## Install

```
xcode-select --install
git clone https://github.com/FeignMan/dotfiles_macos.git ~/.dotfiles
cd ~/.dotfiles; source setup.sh
```

Use `stow` to symlink, eg:

```
stow homebrew
stow zsh
```

## Brew and brew bundle

After the .Brewfile is symlinked into ~/.Brewfile, just use:
`brew bundle --global`

To replace the Brewfile, run:
`brew bundle dump --global -f --describe`
