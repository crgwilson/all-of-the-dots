###############
# Golang jank #
###############

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

alias gt='go test'
alias gtb='go test -bench=.'
alias gtc='go test -cover'
alias gtr='go test -race'
alias rungodoc='echo "Hosting docs on http://localhost:8000" && godoc -http ":8000" -goroot /usr/share/go'
