#!/usr/bin/env bash

read -sp 'git signing key (e.g. ssh-ed25519 ABC...): ' GIT_SIGNING_KEY

echo "Starting setup"

# Install Xcode tools
xcode-select --install

# Install Homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Copy dotfiles
rsync -av ./dotfiles/ ~/

# Install ZSH
brew install zsh

# Download oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

# Install oh-my-zsh plugins
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Set default shell
sudo chsh -s /opt/homebrew/bin/zsh

# Install coding font
brew tap homebrew/cask-fonts
brew install font-meslo-lg-nerd-font

# Install and configure iTerm
# Note: Color theme is stored in com.googlecode.iterm2.plist
brew install --cask iterm2
cp ./com.googlecode.iterm2.plist ~/Library/Preferences/

# Install nvim
brew install neovim

# Install git
brew install git
sed -i -e "s#<REPLACE-ME>#$GIT_SIGNING_KEY#g" ~/.gitconfig # Note: We use # as delimiters because the key contains '/'

# Install various apps
brew install --cask 1password
brew install --cask yubico-authenticator
brew install --cask discord
brew install --cask docker
brew install --cask insomnia
brew install --cask element
brew install --cask hush
brew install --cask obsidian
brew install --cask postico
brew install --cask protonmail-bridge
brew install --cask protonvpn
brew install --cask qbittorrent
brew install --cask slack
brew install --cask signal
brew install --cask teamspeak-client
brew install --cask utm

# Install various cli tools
brew install swiftlint
brew install swift-format

