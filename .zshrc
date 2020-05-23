# WSL is stupid (https://github.com/microsoft/WSL/issues/352)
IS_WSL=`grep -i microsoft /proc/version`
if test "$IS_WSL" != ""; then
  umask 022
fi

for f in ~/zsh/*; do source $f; done
