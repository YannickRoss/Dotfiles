eval "$(starship init zsh)"

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

export VISUAL=nvim
export EDITOR="$VISUAL"

