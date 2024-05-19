# store the command history
export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%F{198}%b%f'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST

# fiddle with the prompt
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{164}%2~%f%b %# '
RPROMPT=\$vcs_info_msg_0_


# aliases
# basic cannot live without
#alias ll='ls -al'
alias ls="exa --icons --group-directories-first"
alias ll="exa --icons --group-directories-first -la"
alias grep='grep --color'
alias tmux='tmux -u'
alias ta='tmux attach-session'

# some git shortcuts
#alias gs='git status'
#alias gc='git commit -m'
#alias ga='git add'


# update the paths
export PATH

# find out which distribution we are running on
LFILE="/etc/*-release"
MFILE="/System/Library/CoreServices/SystemVersion.plist"
if [[ -f $LFILE ]]; then
  _distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')
elif [[ -f $MFILE ]]; then
  _distro="macos"
fi

# set an icon based on the distro
# make sure your font is compatible with https://github.com/lukas-w/font-logos
case $_distro in
    *kali*)                  ICON="ﴣ";;
    *arch*)                  ICON="";;
    *debian*)                ICON="";;
    *raspbian*)              ICON="";;
    *ubuntu*)                ICON="";;
    *elementary*)            ICON="";;
    *fedora*)                ICON="";;
    *coreos*)                ICON="";;
    *gentoo*)                ICON="";;
    *mageia*)                ICON="";;
    *centos*)                ICON="";;
    *opensuse*|*tumbleweed*) ICON="";;
    *sabayon*)               ICON="";;
    *slackware*)             ICON="";;
    *linuxmint*)             ICON="";;
    *alpine*)                ICON="";;
    *aosc*)                  ICON="";;
    *nixos*)                 ICON="";;
    *devuan*)                ICON="";;
    *manjaro*)               ICON="";;
    *rhel*)                  ICON="";;
    *macos*)                 ICON="";;
    *)                       ICON="";;
esac

export STARSHIP_DISTRO="$ICON"

# Load starship
eval "$(starship init zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/root/google-cloud-sdk/path.zsh.inc' ]; then . '/root/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/root/google-cloud-sdk/completion.zsh.inc' ]; then . '/root/google-cloud-sdk/completion.zsh.inc'; fi

# Keybindings 
# Bind Ctrl+Left to backward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[5D" backward-word

# Bind Ctrl+Right to forward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[5C" forward-word
