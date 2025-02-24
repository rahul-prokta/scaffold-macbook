#!/usr/bin/env bash

set -o errexit

REPO_URL=https://github.com/protiumx/.dotfiles.git
SCAFFOLD_PATH="$HOME/scaffold"

reset_color=$(tput sgr 0)

info() {
	printf "%s[*] %s%s\n" "$(tput setaf 4)" "$1" "$reset_color"
}

success() {
	printf "%s[*] %s%s\n" "$(tput setaf 2)" "$1" "$reset_color"
}

err() {
	printf "%s[*] %s%s\n" "$(tput setaf 1)" "$1" "$reset_color"
}

warn() {
	printf "%s[*] %s%s\n" "$(tput setaf 3)" "$1" "$reset_color"
}

install_xcode() {
    # Check if xcode-select is installed
    if ! command -v xcode-select &> /dev/null; then
        info "xcode-select is not installed. Installing..."
        
        # Install xcode-select using the xcode tools package
        xcode-select --install
        
        # Check if installation is successful
        if command -v xcode-select &> /dev/null; then
            info "xcode-select has been installed successfully."
        else
            err "Installation of xcode-select failed."
        fi
    else
        warn "xcode-select is already installed."
    fi
}

install_homebrew() {
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    
    # Get the current logged-in username dynamically
    USERNAME=$(whoami)
    
    # Check if Homebrew is already installed
    if command -v brew &>/dev/null; then
        warn "Homebrew is already installed"
    else
        info "Installing Homebrew..."
        
        # Reset sudo timeout to allow Homebrew installation in non-interactive mode
        sudo --validate
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        
        # Adding Homebrew to PATH
        info "Adding Homebrew to PATH..."
        
        # Update the .zprofile to include Homebrew for the current user
        info "Updating /Users/$USERNAME/.zprofile"
        echo >> /Users/$USERNAME/.zprofile
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$USERNAME/.zprofile
        
        # Apply the changes to the current session
        eval "$(/opt/homebrew/bin/brew shellenv)"
        
        # Provide instructions for the user
        success "Homebrew has been installed and added to your PATH."
        success "Run 'brew help' to get started."
    fi
}

install_git() {
    if command -v git >/dev/null 2>&1; then
        info "Git is already installed."
    else
        info "Installing Git..."
        brew install git
    fi
}

info "####### scaffold #######"
read -p "Press enter to start:"
info "Bootstraping..."

install_xcode
install_homebrew

info "Installing Git"
install_git

#info "Cloning .dotfiles repo from $REPO_URL into $SCAFFOLD_PATH"
#git clone "$REPO_URL" "$REPO_PATH"

info "Change path to $REPO_PATH"
cd "$SCAFFOLD_PATH" >/dev/null

./install.sh

