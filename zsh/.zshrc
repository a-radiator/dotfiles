# zsh path installation
export ZSH="$HOME/.oh-my-zsh"

# zsh theme
ZSH_THEME="robbyrussell"

# zsh plugins 
plugins=(
git
macos 
)

source $ZSH/oh-my-zsh.sh

# aliases
alias pyprojects='cd $HOME/files/notes/obsidian-notes/obsidian-vault/learning/python'
alias vim="nvim" 
alias vi="nvim"
alias s="spotify"
alias coder='code --reuse-window'
alias projects='cd $HOME/files/projects' 
alias digs='dig +short'
alias settings='vim $HOME/Library/Application\ Support/Code/User/settings.json'
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"