eval "$(zoxide init zsh)"
_zoxide_zi_widget() {
  zi "$BUFFER"
  BUFFER=""
  zle accept-line
  zle reset-prompt
}
zle -N _zoxide_zi_widget
bindkey '^g' _zoxide_zi_widget
