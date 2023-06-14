#!/usr/bin/env bash

# Run from ~/.ssh directory

echo "Generate SSH key"
ssh-keygen -t rsa -C "Bradley.Davis@okcoin.com" -f "id_rsa_okcoin" -b 4096

echo "Add key to SSH agent"
ssh-add ~/.ssh/id_rsa_okcoin

if [[ $platform == 'Linux' ]]; then
  xclip -sel clip < ~/.ssh/id_rsa_okcoin.pub
  echo "Copied to Linux clipboard"
elif [[ $platform == 'Darwin' ]]; then
  pbcopy < ~/.ssh/id_rsa_okcoin.pub
  echo "Copied to Mac clipboard"
fi

echo "Add SSH key in Github Settings"

# vim: ft=sh syn=sh
