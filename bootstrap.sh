#!/usr/bin/env bash
echo "Checking requirements..."

if [ "$(id -u)" == "0" ]; then
	echo "Don't run this script from root user!"
	exit 1
fi

if ! type "ruby" > /dev/null; then
	echo "Please install ruby before!"
	exit 1
fi

if ! type "curl" > /dev/null; then
	echo "Please install curl before!"
	exit 1
fi

if ! type "node" > /dev/null; then
	brew install node
fi

if ! type "brew" > /dev/null; then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
fi

if ! type "corkscrew" > /dev/null; then
	brew install corkscrew
fi

echo "Installing YADR..."

curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh | sh

echo "Configuring browser proxy"
if [ ! -d "$HOME/.proxy" ]; then
	cp -R ./.proxy $HOME/
	node $HOME/.proxy/proxy.js&

	echo "Browser proxy configured. Don't remember to provide with correct proxy configuration in ~/.proxy/proxy.pac file and configure your browser!"
else
	echo "Browser proxy is already configured"
fi

echo "Configuring SSH proxy"
if [ ! -f "$HOME/.ssh/config" ]; then
	cp -R ./.ssh/config $HOME/.ssh/

	echo "SSH proxy configured. Don't remember to provide with correct proxy configuration in ~/.ssh/config file!"
else
	echo "SSH proxy is already configured"
fi

echo "Dotfiles configuration successfully completed"