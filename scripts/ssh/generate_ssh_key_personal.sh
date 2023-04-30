#!/usr/bin/env bash

# Run from ~/.ssh directory

echo "Generate SSH key"
ssh-keygen -t rsa -C "2238331+BradleyAllanDavis@users.noreply.github.com" -f "id_rsa_personal" -b 4096

echo "Add key to SSH agent"
ssh-add ~/.ssh/id_rsa_personal

if [[ $platform == 'Linux' ]]; then
  xclip -sel clip < ~/.ssh/id_rsa_personal.pub
  echo "Copied to Linux clipboard"
elif [[ $platform == 'Darwin' ]]; then
  pbcopy < ~/.ssh/id_rsa_personal.pub
  echo "Copied to Mac clipboard"
fi

echo "Add SSH key in Github Settings"

# vim: ft=sh syn=sh
