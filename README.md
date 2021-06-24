# macos-developer-setup
My personal setup guide for setting up a macOS developer environment.

## 1 - Basics

- Go through System Preferences

- Don't forget to setup Firewall and FireVault!

- Give Terminal FullDiskAccess in System Preferences

## 2 - Terminal

1. Install Xcode Developer Tools: `xcode-select --install`

2. Install Homebrew https://brew.sh

3. Install ZSH `brew install zsh`

4. Set ZSH as default shell: `chsh -s /usr/local/bin/zsh`. Restart Terminal.

5. Install Oh My Zsh https://ohmyz.sh/#install
    
    In case an error occurs: `compaudit | xargs chmod g-w,o-w`
    
6. Install powerlevel10k theme

   - Download MaterialDark Terminal theme and set as default.

   - Tap into homebrew fonts `brew tap homebrew/cask-fonts`
  
   - Install recommended Meslo LG font family `brew cask install font-meslo-lg-nerd-font`
   
   - Open MaterialDark theme in the Terminal settings and set font to Meslo LGS Nerd Font. Font size ~13
   
   - Install powerlevel10k `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`
   
   - Set `ZSH_THEME="powerlevel10k/powerlevel10k"` in `~/.zshrc`
   
   - Close and reopen Terminal to start powerlevel10 installation wizard (LEAN;ASCII;256colors;NoTime;OneLine;Sparse;Concise;TransientOn)
   
   - Plugins: git, zsh-syntax-highlighting, zsh-autosuggestions
   
7. Install essential zsh plugins with oh-my-zsh plugin manager

   - zsh-autosuggestions: https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh

   - zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh
   
## Some magic

   - Generate a new ssh key
   
     - Setup ssh config
   
## Important apps and tools

   - Install git `brew install git` and apply some basic configuration: https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup

   - View the tools.txt
