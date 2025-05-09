# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    nvm # This will source nvm and add autocompletion
)

# Defer loading nvm until we run node, npm, npx, pnpm, pnpx, yarn, or corepack
zstyle ':omz:plugins:nvm' lazy yes
# Automatically load node version when .nvmrc file is present
zstyle ':omz:plugins:nvm' autoload yes

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Go
export GOPATH=$HOME/go
path+=$GOPATH/bin

# Postgres
path+=$HOMEBREW_PREFIX/opt/postgresql@17/bin

