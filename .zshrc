export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt inc_append_history share_history
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

# zsh theme
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats "[%b]"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

PROMPT="
%F{cyan}%c %F{green}%1(v|%1v|)%f%f
$ "

# === cool-peco init ===
FPATH="$FPATH:$HOME/cool-peco"
autoload -Uz cool-peco
cool-peco
# ======================

# PullRequestをpecoに投げるやつ
# brew install ghしたあとにgh auth loginが必要
function peco-checkout-pull-request () {
    local selected_pr_id=$(gh pr list | peco | awk '{ print $1 }')
    if [ -n "$selected_pr_id" ]; then
        BUFFER="gh pr checkout ${selected_pr_id}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-checkout-pull-request

bindkey '^r' cool-peco-history # ctrl+r
bindkey '^l' peco-checkout-pull-request # ctrl+p

alias pp='cool-peco-ghq'
alias gg='ghq get'
alias gp='git push origin HEAD'
alias gl='git pull --rebase origin $(git rev-parse --abbrev-ref HEAD)'
alias gm='git checkout master'
alias gb='git checkout -b'
alias gc='git switch `git branch | peco | sed -e "s/\* //g" | awk "{print \$1}"`'
alias gr='git reset --soft HEAD^'
alias gs='git stash'
alias code="code-insiders"
alias tm='tmux'

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$(brew --prefix openssl@1.1)/bin:$PATH"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"
export PATH="$(brew --prefix openssl@1.1)/bin:$PATH"
export PATH="$(brew --prefix postgresql@11)/bin:$PATH"
export PATH="$(brew --prefix mysql@5.7)/bin:$PATH"

eval "$(rbenv init -)"