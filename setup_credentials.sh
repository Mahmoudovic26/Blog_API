#!/bin/bash

if [ ! -f /rails/config/credentials/development.key ]; then
    # Generate a random key
    key=$(openssl rand -hex 32)
    echo $key > /rails/config/credentials/development.key
    EDITOR="echo 'secret_key_base: $(openssl rand -hex 64)' > " rails credentials:edit --environment development
fi