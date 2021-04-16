#!/bin/bash
source ./scripts/yaml-parser.sh
create_variables ./nginx-mapping.yml 'nginx_'

echo "- Setting up homebrew"
command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew Now"; \
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; }

echo "- Setting up yarn"
brew install yarn
yarn install

printf %s "- Copy .env-example? WARNING this will overwrite any existing environment variables (y/n)? "
read -r RESP
if [ "$RESP" != "${RESP#[Yy]}" ]; then
  cp .env-example .env
fi

printf %s "- Build the docker image (y/n)? "
read -r RESP
if [ "$RESP" != "${RESP#[Yy]}" ]; then
  docker-compose build
fi

echo "- Install dev-nginx"
brew tap guardian/homebrew-devtools
brew install guardian/devtools/dev-nginx

echo "- Setup mapping"
dev-nginx setup-app nginx-mapping.yml

dev-nginx restart-nginx
