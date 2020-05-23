#######################
# MacOS specific jank #
#######################
if [ $(uname -s) = "Darwin" ]; then
  export LDFLAGS=-L/usr/local/opt/zlib/lib
  export CPPFLAGS=-I/usr/local/opt/zlib/include
  export CFLAGS=-I$(xcrun --show-sdk-path)/usr/include

  # Use stuff installed from brew
  export PATH=/usr/local/opt/openssl@1.1/bin:/usr/local/lib/ruby/gems/2.7.0/bin:/usr/local/opt/sqlite/bin:$PATH

  # -------
  # Aliases
  # -------
  alias t=todolist
  alias pgadmin='open /Applications/pgAdmin\ 4.app'
  alias refresh-dns='sudo killall -HUP mDNSResponder'

  # ---------
  # Functions
  # ---------
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
fi
