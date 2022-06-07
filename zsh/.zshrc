# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(sudo git web-search history zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Preferred editor
export EDITOR='nvim'

# aliasas
alias up="cd .."
alias des="cd ~/Desktop"
alias dev="cd ~/Desktop/development"
alias dot="cd ~/dotfiles"
alias notes="cd ~/Desktop/notes"
alias src="source venv/bin/activate"
alias csrc="python3 -m venv venv"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# p10k theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Replace zsh tab completion with fzf
source ~/.fzf-tab/fzf-tab.plugin.zsh
