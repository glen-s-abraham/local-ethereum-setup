FROM ethereum/client-go:v1.10.1

ARG ACCOUNT_PASSWORD

# Copy necessary files
COPY genesis.json .
COPY create_accounts.sh /usr/local/bin/create_accounts.sh

# Ensure the script has executable permissions
RUN chmod +x /usr/local/bin/create_accounts.sh

# List files to debug
RUN ls -la /usr/local/bin

# Run the script as root to create accounts and fetch private keys
USER root

RUN /usr/local/bin/create_accounts.sh

# Initialize Geth with the genesis block
RUN geth init genesis.json \
    && rm -f ~/.ethereum/geth/nodekey \
    && echo ${ACCOUNT_PASSWORD} > /password.txt \
    && geth account new --password /password.txt \
    && rm -f /password.txt

# Change back to user `geth`
USER geth

ENTRYPOINT ["geth"]