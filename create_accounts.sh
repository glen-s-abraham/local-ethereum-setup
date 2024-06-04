#!/bin/bash

# Number of accounts to create
NUM_ACCOUNTS=5
KEYFILES_DIR="/root/.ethereum/keystore"
PASSWORD_FILE="/root/.ethereum/password.txt"

# Make sure the password file is in place
mkdir -p $KEYFILES_DIR
echo "" > $PASSWORD_FILE

# Create accounts and print their addresses and private keys
for i in $(seq 1 $NUM_ACCOUNTS); do
  ACCOUNT_OUTPUT=$(geth account new --password $PASSWORD_FILE)
  ADDRESS=$(echo $ACCOUNT_OUTPUT | grep -oP '(?<=Address: \{\K[0-9a-fA-F]+(?=\})')
  KEYFILE=$(ls -t $KEYFILES_DIR | head -1)

  echo "Account $i Address: 0x$ADDRESS"
  echo "Account $i Keyfile: $KEYFILES_DIR/$KEYFILE"
done