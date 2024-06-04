from eth_account import Account
import json
import os

# Directory where the keyfiles are stored
keyfiles_dir = "./keystore"

# Decrypt each keyfile in the directory
for filename in os.listdir(keyfiles_dir):
    with open(os.path.join(keyfiles_dir, filename), 'r') as keyfile:
        encrypted_key = keyfile.read()
        private_key = Account.decrypt(encrypted_key, '')
        print(f"Private key for {filename}: {private_key.hex()}")