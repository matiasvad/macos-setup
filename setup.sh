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
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Homebrew Packages
cd ~
echo "Installing Homebrew packages"

homebrew_packages=(
  "git"
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
  "1password"
  "adobe-creative-cloud"
  "cleanshot"
  "discord"
  "dropbox"
  "fantastical"
  "figma"
  "firefox"
  "google-chrome"
  "hey"
  "hyper"
  "imageoptim"
  "istat-menus"
  "mamp"
  "nocturnal"
  "numi"
  "pastebot"
  "postman"
  "rectangle"
  "rocket"
  "slack"
  "spark"
  "tableplus"
  "the-unarchiver"
  "toggl-track"
  "tower"
  "transmit"
  "tweetbot"
  "vanilla"
  "visual-studio-code"
  "vlc"
)

# extra apps to install
# logi options

# apps in mac store
# amphetamine
# todoist

for homebrew_cask_package in "${homebrew_cask_packages[@]}"; do
  brew cask install "$homebrew_cask_package"
done

# configure git
git config --global user.name "Matias Vad"
git config --global user.email "matias@hey.com"
gh config set git_protocol "ssh"

# Install Composer
echo "Installing Composer"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Create projects directory called batcave
echo "Creating a Batcave directory"
mkdir -p $HOME/documents/batcave

# Generate SSH key
echo "Generating SSH keys"
ssh-keygen -t rsa

echo "Copied SSH key to clipboard - You can now add it to Github"
pbcopy < ~/.ssh/id_rsa.pub

# zsh and oh-my-zsh
echo "Adding ZSH"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z

# zsh configuration
touch ~/.my-zshrc

# PATH stuff
echo "export PATH=$HOME/.composer/vendor/bin:$PATH" >> ~/.my-zshrc

# aliases
echo "alias list='ls --group-directories-first'" >> ~/.my-zshrc
echo "alias push='git push'" >> ~/.my-zshrc
echo "alias pull='git pull'" >> ~/.my-zshrc
echo "alias add='git add -A'" >> ~/.my-zshrc
echo "alias commit='git commit -m'" >> ~/.my-zshrc
echo "alias status='git status'" >> ~/.my-zshrc
echo "alias checkout='git checkout'" >> ~/.my-zshrc
echo "alias merge='git merge'" >> ~/.my-zshrc
echo "alias clean='git clean -f -d'" >> ~/.my-zshrc
echo "alias reset='git reset --hard'" >> ~/.my-zshrc
echo "alias nope='git reset --hard'" >> ~/.my-zshrc

echo "alias y='yarn'" >> ~/.my-zshrc
echo "alias ys='yarn start'" >> ~/.my-zshrc

echo "alias ni='npm install'" >> ~/.my-zshrc
echo "alias ns='npm start'" >> ~/.my-zshrc
echo "alias nb='npm run build'" >> ~/.my-zshrc
echo "alias nd='npm run dev'" >> ~/.my-zshrc
echo "" >> ~/.my-zshrc

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

# Complete
echo "Installation Complete"
