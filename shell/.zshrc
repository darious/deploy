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

# spell check alias
alias spell='scspell'
alias spell-unstaged='git diff --name-only | grep yml | cut -c 5- | xargs -o scspell'
alias spell-staged='git diff --name-only --cached | grep yml | cut -c 5- | xargs -o scspell'
alias spell-lastcommit='git log -1 --name-only | grep .yml | cut -c 5- | xargs -o scspell'

# work tools
alias dbt='pipenv run dbt --use-experimental-parser'
alias sqlfluff='pipenv run sqlfluff'
alias python='python3'
alias pip='pip3'
#alias docker='podman'
alias pipenv-list='for venv in ~/.local/share/virtualenvs/* ; do basename $venv; cat $venv/.project | sed "s/\(.*\)/\t\1\n/" ; done'

# some git shortcuts
alias gs='git status'
#alias gc='git commit -m'
#alias ga='git add'


# paths for python selection
path=('/Library/Frameworks/Python.framework/Versions/3.9/bin' $path)
PYTHON_BIN_PATH="$(python3 -m site --user-base)/bin"
PATH="$PYTHON_BIN_PATH:$PATH"

# path for vs code
PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

# update the paths
export PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Applications/google-cloud-sdk/path.zsh.inc' ]; then . '/Applications/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Applications/google-cloud-sdk/completion.zsh.inc' ]; then . '/Applications/google-cloud-sdk/completion.zsh.inc'; fi

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

# stuff for pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Load starship
eval "$(starship init zsh)"

# dbt autocomplete
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
source ~/.dbt-completion.bash
