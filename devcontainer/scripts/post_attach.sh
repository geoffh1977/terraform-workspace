#!/bin/bash
# Commands To Be Executed Once VS Code Attaches To The Container

# Ensure We're In Our Working Directory
cd /project || exit 1

# Copy In Bashrc If It Doesn't Exist
if [ ! -f "${HOME}/.bashrc" ]
then
  cp -a /etc/skel/.bashrc "${HOME}"
  chown user:user "${HOME}/.bashrc"
  chmod 0755 "${HOME}/.bashrc"
fi

# Execute Pre-Commit Install If No Pre-Commit Hook
if [ -d /project/.git ]
then
  if ! grep -q "pre-commit.com" /project/.git/hooks/pre-commit
  then
    pre-commit install
  fi
fi
