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

# Install Ghostty
brew install --cask ghostty
cp ./ghosttyconfig ~/Library/Application Support/com.mitchellh.ghostty/config

# Install nvim
brew install neovim

# Install git
brew install git
sed -i -e "s#<REPLACE-ME>#$GIT_SIGNING_KEY#g" ~/.gitconfig # Note: We use # as delimiters because the key contains '/'

# Install various apps
brew install --cask 1password
brew install --cask blender
brew install --cask brave-browser
brew install --cask db-browser-for-sqlite
brew install --cask discord
brew install --cask docker
brew install --cask figma
brew install --cask hush
brew install --cask linear
brew install --cask notion
brew install --cask obsidian
brew install --cask postico
brew install --cask protonvpn
brew install --cask proton-mail
brew install --cask qbittorrent
brew install --cask slack
brew install --cask spotify
brew install --cask tailscale
brew install --cask teamspeak-client
brew install --cask vlc
brew install --cask yubico-authenticator

# Install various cli tools
brew install caddy
brew install go
brew install git-delta
brew install ripgrep
brew install tinygo

# Install nvm and enable corepack for pnpm
# We specify PROFILE=/dev/null to avoid nvm messing with our .zshrc
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash'
nvm install --lts
npm install --global corepack@latest
corepack enable pnpm
