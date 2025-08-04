# use neovim
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias nvp="nvim --cmd 'set rtp+=$(pwd)"

# openssl
alias read-csr='openssl req -text -noout -verify -in'
alias read-cert='openssl x509 -noout -text -in'
alias cert-serial='openssl x509 -serial -noout -in'
alias encrypt-file='openssl enc -aes-256-cbc -salt -in file.txt -out file.txt.enc'
alias decrypt-file='openssl enc -aes-256-cbc -d -in file.txt.enc -out file.txt'
alias openssl256sum='openssl dgst -sha256'

# network troubleshooting
alias ping='ping -c 3'
alias knockknock='nmap -sn'

# python
alias ac='. venv/bin/activate'
alias deac='deactivate'

pyac() {
  if [ -e "./activate" ]; then
    source ./activate
  elif [ -d "./venv" ]; then
    source ./venv/bin/activate
  elif [ -d "./.venv" ]; then
    source ./.venv/bin/activate
  else
    local stripped_pwd="${PWD##*/}"
    local activate_script_path="${stripped_pwd//_trunk}/activate"
    source "$activate_script_path"
  fi
}

# go
alias gt='go test'
alias gtb='go test -bench=.'
alias gtc='go test -cover'
alias gtr='go test -race'
alias rungodoc='echo "Hosting docs on http://localhost:8000" && godoc -http ":8000" -goroot /usr/share/go'

# java
alias stop-gradle="./gradlew --stop"

countryroads() {
  if [[ $(uname) == "Darwin" ]]; then
    # for work
    # local jdks=($(find . ~/.local/opt -maxdepth 3 -wholename "*jdk*/Contents/Home"))
    local jdks=($(find . /Library/Java/JavaVirtualMachines -maxdepth 3 -wholename "*jdk*/Contents/Home"))
  else
    local jdks=($(find . ~/.local/opt -maxdepth 1 -wholename "*jdk*"))
  fi

  local idx=1
  echo "Pick a JAVA_HOME:"
  for j in $jdks; do
    echo "$idx - $j"
    idx=$(expr $idx + 1)
  done

  local jdk_choice_idx
  vared -p 'Enter the number corresponding to the the JDK you want: ' -c jdk_choice_idx
  local chosen="${jdks[$jdk_choice_idx]}"
  echo "You picked index - $jdk_choice_idx - which is path - $chosen"
  export JAVA_HOME="$chosen"
}

takemehome() {
  if [ -f ./product-spec.json ]; then
    local from_spec=$(jq -r '.build.versions.java' ./product-spec.json)
    echo "Found ${from_spec} in product-spec."
    export JAVA_HOME=`find /Library/Java/JavaVirtualMachines -name "*$from_spec*"`
    echo "Set JAVA_HOME=$JAVA_HOME"
  else
    echo "There is no product-spec here, you absolute fool."
  fi
}

# terraform
alias tf="terraform"

# ansible
alias ml='molecule login'
alias mt='molecule test'
alias mc='molecule converge'
alias md='molecule destroy --all'

# aws
alias ec2ls="aws ec2 describe-instances --query 'sort_by(Reservations[].Instances[].{Name:Tags[?Key==\`Name\`]|[0].Value, Environment:Tags[?Key==\`Environment\`]|[0].Value, Purpose:Tags[?Key==\`Purpose\`]|[0].Value, ID:InstanceId, AZ:Placement.AvailabilityZone, PrivateIP:PrivateIpAddress, PublicIP:PublicIpAddress, State:State.Name}, &Name)' --output table --region"
alias ec2-reboot="aws ec2 reboot-instances"

# Kubernetes
alias k='kubectl'

# docker
alias start-docker='open --background -a Docker'
alias stop-docker='test -z "$(docker ps -q 2>/dev/null)" && osascript -e "quit app \"Docker\""'
alias dic='docker rmi $(docker images --filter "dangling=true" -q)'
alias drd9='docker run -it --rm debian:9'
alias drd10='docker run -it --rm debian:10'
alias drc8='docker run -it --rm centos:8'

# docker-compose
alias dkc='docker-compose'
alias dkcu='dkc up'
alias dkcd='dkc down'
alias dkcp='dkc ps'

# Vagrant
alias vu='vagrant up'
alias vr='vd && vu'
alias vd='vagrant destroy -f'
alias vp='vagrant provision'
alias vs='vagrant status'
alias vss='vagrant ssh'
alias vgs='vagrant global-status'
alias vagrant destroy='vagrant destroy -f'

# misc utils
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias get_top_open_files="lsof | awk '{print $1}' | uniq -c | sort -rn | head"
alias c='clear'
alias mkdir='mkdir -pv'
alias now='date +"%T"'
alias shrug='echo "¯\_(ツ)_/¯"'
alias weather='curl wttr.in'
alias party='curl parrot.live'
alias jcat='python -m json.tool'
alias halp='cat ~/notes/halp|fzf'

case $(uname -s) in
  Darwin)
      # TODO: Move the exports into 00_exports.zsh
      export LDFLAGS=-L/usr/local/opt/zlib/lib
      export CPPFLAGS=-I/usr/local/opt/zlib/include
      export CFLAGS=-I$(xcrun --show-sdk-path)/usr/include

      # Use stuff installed from brew
      export PATH=/usr/local/opt/openssl@1.1/bin:/usr/local/lib/ruby/gems/2.7.0/bin:/usr/local/opt/sqlite/bin:$PATH
      alias t=todolist
      alias pgadmin='open /Applications/pgAdmin\ 4.app'
      alias fuckingdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"

      alias ls="ls -G"

      sox () {
        sox_help() { echo "Helper utility to toggle the MacOS SOCKS proxy. Pass on or off to set proxy state." }
        case "$1" in
        on*|off*)
          networksetup -setsocksfirewallproxystate Wi-Fi $1
          echo "SOCKS proxy has been turned $1"
          ;;
        *)
          sox_help
          ;;
        esac
      }

    ;;
  Linux)
    # add color to common utilities by default
    alias ls="ls --color=auto --group-directories-first"
    alias grep="grep --color=auto"
    alias diff="diff --color=auto"
    alias ip="ip -color=auto"
    ;;
  *)
    ;;
esac

lscomma() {
  ls -p $1 | grep -v / | tr '\n' ','
}

lsspace() {
  ls -p $1 | grep -v / | tr '\n' ' '
}

# FOR WORK, DON'T CHECK IN ANYTHING IMPORTANT
alias shellme="ssh $WORK_SHELL_HOST"
alias devme="ssh $WORK_DEV_HOST"
alias oc='oncall'
alias onq='oncall query --now --type primary'
