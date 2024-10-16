# zinit initialization
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# history options
HISTSIZE=500
HIST_IGNORE_DUPS=1

# plugins
zinit light Aloxaf/fzf-tab
zinit light spaceship-prompt/spaceship-prompt
zinit light zsh-users/zsh-syntax-highlighting

# OMZ Plugins
zinit snippet OMZ::plugins/gitignore/gitignore.plugin.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh

# history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# auto complete
fpath+=$HOME/.my_comp/conda-zsh-completion/
compinit

# auto cd
setopt auto_cd

# zoxide
eval "$(zoxide init zsh)"

# fzf
source <(fzf --zsh)

# text editor
alias vi="nvim"
