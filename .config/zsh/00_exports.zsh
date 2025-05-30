# WSL is stupid (https://github.com/microsoft/WSL/issues/352)
IS_WSL=`uname -r | grep -i microsoft`
if test "$IS_WSL" != ""; then
  umask 022
fi

ulimit -n 4096

export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

export USER_LOCAL_HOME="$HOME/.local"
export USER_LOCAL_BIN="$USER_LOCAL_HOME/bin"
export USER_LOCAL_LIB="$USER_LOCAL_HOME/lib"
export USER_LOCAL_OPT="$USER_LOCAL_HOME/opt"
export USER_LOCAL_TMP="$USER_LOCAL_HOME/tmp"
export XDG_DATA_HOME="$USER_LOCAL_HOME/share"
export XDG_STATE_HOME="$USER_LOCAL_HOME/state"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# zsh history
export HISTFILE="$XDG_CACHE_HOME/zsh/zsh_history"
export SAVEHIST=10000
export HISTSIZE=10000

# Starship prompt
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"

# Antigen
export ADOTDIR=$XDG_CACHE_HOME/antigen

# Use nvim by default
export EDITOR='nvim'

# SSH agent
if [ -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

if [ -d "$HOME/.1password" ]; then
  export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
fi


# GPG
export GPG_TTY=$(tty)

# Java
if [ -d "/usr/lib/jvm/java-11-openjdk-amd64" ]; then
  export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
fi

# pyenv
# export PYENV_ROOT="$USER_LOCAL_OPT/pyenv"

# AWS
export AWS_PAGER=""  # I don't remember what this is for...

# Ansible
export ANSIBLE_FORCE_COLOR=true

# Vagrant
export VAGRANT_DEFAULT_PROVIDER='virtualbox'
# export VAGRANT_DEFAULT_PROVIDER='libvirt'

# Hashicorp Packer
export PACKER_CACHE_DIR="$XDG_CACHE_HOME/packer_cache"

# Volta
export VOLTA_HOME="$USER_LOCAL_OPT/volta"
export VOLTA_BIN="$VOLTA_HOME/bin"

# Bundle
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle/config"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle/cache"
export BUNDLE_USER_PLUGIN="$XDG_CACHE_HOME/bundle/plugin"

# Path
export PATH="$USER_LOCAL_BIN:$VOLTA_BIN:$PATH"

# WORK
export WORK_SHELL_HOST=""
export WORK_DEV_HOST=""

export QT_QPA_PLATFORMTHEME="qt6ct"
export QT_QPA_PLATFORM="wayland"
