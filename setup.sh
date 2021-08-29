# how to run this thingy
# create a file on your mac called setup.sh
# run it from terminal with: sh setup.sh

# heavily inspired by https://twitter.com/damcclean
# https://github.com/damcclean/dotfiles/blob/master/install.sh

#!/bin/bash
set -euo pipefail

# Display message 'Setting up your Mac...'
echo "Setting up your Mac..."
sudo -v

# Homebrew - Installation
echo "Installing Homebrew"

if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install Homebrew Packages
cd ~
echo "Installing Homebrew packages"

homebrew_packages=(
  "git"
  "gulp"
  "php"
  "node"
  "nvm"
  "yarn"
  "zsh"
  "zsh-completions"
  "zsh-autosuggestions"
  "zsh-syntax-highlighting"
  "romkatv/powerlevel10k/powerlevel10k"
)

for homebrew_package in "${homebrew_packages[@]}"; do
  brew install "$homebrew_package"
done

# Install Casks
echo "Installing Homebrew cask packages"

homebrew_cask_packages=(
  "basecamp"
  "cleanshot"
  "discord"
  "docker"
  "figma"
  "firefox-developer-edition"
  "hey"
  "hyper"
  "imageoptim"
  "istat-menus"
  "local"
  "numi"
  "pastebot"
  "postman"
  "rectangle"
  "rocket"
  "tableplus"
  "the-unarchiver"
  "toggl-track"
  "tower"
  "transmit"
  "vanilla"
  "visual-studio-code"
  "vlc"
)

# extra apps to install
# logi options

# apps in mac store
# fantastical

# spark
# tweetbot

for homebrew_cask_package in "${homebrew_cask_packages[@]}"; do
  brew install --cask "$homebrew_cask_package"
done

# configure git
git config --global user.name "Matias Vad"
git config --global user.email "matias@hey.com"

# Install Composer
echo "Installing Composer"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Generate SSH key
echo "Generating SSH keys"
ssh-keygen -t ed25519

touch ~/.ssh/config

open ~/.ssh/config

# Host *
#  AddKeysToAgent yes
#  # UseKeychain yes Only add if passphrase is used
#  IdentityFile ~/.ssh/id_ed25519

echo "Copied SSH key to clipboard - You can now add it to Github"
pbcopy < ~/.ssh/id_ed25519.pub

# zsh and oh-my-zsh
echo "Adding ZSH"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z

# zsh configuration
touch ~/.my-zshrc

# PATH stuff
echo "export PATH=$HOME/.composer/vendor/bin:$PATH" >> ~/.my-zshrc

# zsh plugins
echo "plugins=(git zsh-completions zsh-z)" >> ~/.my-zshrc
echo "source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.my-zshrc
echo "source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.my-zshrc
echo "source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.my-zshrc

# add our zshrc config to the main zshrc config
echo ". ~/.my-zshrc" >> "$HOME/.zshrc"

# finally changing default shell to zsh (probably not needed with catalina?)
# chsh -s /bin/zsh

# for styling the zsh theme powerlevel10k (https://github.com/romkatv/powerlevel10k)
# change ICON_FOREGROUND (color info: https://github.com/romkatv/powerlevel10k#change-the-color-palette-used-by-your-terminal)
# change ICON_BACKGROUND (color choices 0 to 255: https://www.0to255.com/)
# uncomment and change ICON_CONTENT_EXPANSION
# set SHORTEN_STRATEGY to truncate_to_last (only shows 1 folder)

# Show dock instantly on hover, when hidden - Apple Silicon version
echo "Showing dock instantly"
defaults write com.apple.dock autohide-delay -float 0 && defaults write com.apple.dock autohide-time-modifier -float 0.4 && killall Dock

# Complete
echo "Installation Complete"
