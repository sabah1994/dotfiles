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
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border
  --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
  --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
'

# p10k theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Replace zsh tab completion with fzf
# TODO align fzf and fzf-tab colours
source ~/.fzf-tab/fzf-tab.plugin.zsh
