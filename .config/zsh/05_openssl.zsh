################
# OpenSSL jank #
################

# -------
# Aliases
# -------

# ---------
# Functions
# ---------
# Generate an aes key w/ openssl
aes-key() {
  openssl rand -out out.key 32
}

# Wrap an aes key with a given RSAES OAEP SHA1 wrapping key
wrap-aes-key() {
  openssl rsautl -encrypt -in $1 -oaep -inkey $2 -pubin -keyform DER -out $1.enc
}

gen-priv-key() {
  help() {
    echo "Create a private key using OpenSSL with either RSA (default) or ECC (secp384r1)"
    echo "Args:"
    echo "  1. The name of the key to create"
    echo "  2. The type of key to create (optional)"
  }

  if [ -z "$2" ]; then
    TYPE="rsa"
  else
    TYPE=$2
  fi

  NAME=$1

  if [ -z "$NAME" ]; then
    help
  fi

  if [ "$TYPE" = "rsa" ]; then
    openssl genrsa -out $NAME 4096
  elif [ "$TYPE" = "ecc" ]; then
    openssl ecparam -out $NAME -name secp384r1 -genkey
  else
    help
  fi
}

# TODO: Make this function less stupid
encrypt-priv-key() {
  help() {
    echo "Encrypt an OpenSSL private key with a passphrase"
    echo "Args:"
    echo "  1. The path of the file to encrypt"
    echo "  2. The type of key we're encrypting (ecc or rsa) *Defaults to rsa*"
  }

  if [ -z "$2" ]; then
    TYPE="rsa"
  else
    TYPE=$2
  fi

  if [ -z "$1" ]; then
    help
  else
    if [ "$TYPE" = "ecc" ]; then
      openssl ec -in $1 -out $1 -aes256
    else
      openssl $TYPE -in $1 -out $1 -aes256
    fi
  fi
}

gen-csr() {
  help() {
    echo "Create a CSR using OpenSSL"
    echo "Args:"
    echo "  1. Path to private key"
    echo "  2. Path to create the csr file"
    echo "  3. Path to openssl.cnf"
  }

  KEY=$1
  CSR=$2
  CNF=$3

  if [ -z "$KEY" ] || [ -z "$CSR" ] || [ -z "$CNF" ]; then
    help
  else
    openssl req -new -key $KEY -out $CSR -config $CNF -sha384
  fi
}
