#!/bin/zsh

item="PACKAGE_NAME"
#######################
# check something set #
if [[ "$item" == "" ]]; then
echo "****  No item set! exiting ****"
exit 1
fi

UNAME_MACHINE="$(uname -m)"

ConsoleUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

# Check if the item is already installed. If not, install it

if [[ "$UNAME_MACHINE" == "arm64" ]]; then
    # M1/arm64 machines
    cd /tmp/ # This is required to use sudo as another user or you get a getcwd error
        if [[ $(sudo -H -iu ${ConsoleUser} /opt/homebrew/bin/brew list --casks | grep -c ${item}) == "1"  ]]; then
        echo "${item} is installed already. Skipping installation"
        else
        echo "${item} is either not installed or not available. Attempting installation..."
        sudo -H -iu ${ConsoleUser} /opt/homebrew/bin/brew install --cask ${item}
        fi
else
    # Intel machines
    cd /tmp/ # This is required to use sudo as another user or you get a getcwd error
        if [[ $(sudo -H -iu ${ConsoleUser} /usr/local/bin/brew list --casks | grep -c ${item}) == "1" ]]; then
        echo "${item} is installed already. Skipping installation"
        else
        echo "${item} is either not installed or not available. Attempting installation..."
        sudo -H -iu ${ConsoleUser} /usr/local/bin/brew install --cask ${item}
        fi
fi