# macos-developer-setup
My personal setup guide for setting up a macOS developer environment.

## 1 - Basics

- Go through System Preferences

- Don't forget to setup Firewall and FireVault!

## 2 - Terminal

1. Install Xcode Developer Tools: `xcode-select --install`

2. Install Homebrew https://brew.sh

3. Install ZSH `brew install zsh`

4. Set ZSH as default shell: `chsh -s /usr/local/bin/zsh`. Restart Terminal.

5. Install Oh My Zsh https://ohmyz.sh/#install
    
    In case an error occurs: `compaudit | xargs chmod g-w,o-w`
