packages=(
	curl
	httpie     # https://github.com/httpie/httpie
	jq
	lazydocker # https://github.com/jesseduffield/lazydocker
	node
	openssl
	procs      # https://github.com/dalance/procs/
	python3
	shellcheck # finds bugs in your shell scripts.
	telnet
	websocat   # https://github.com/vi/websocat
	wget
	zsh
)

install_sdkman_and_jdks() {
    info "Installing SDKMAN..."
    # If SDKMAN isn't already installed, install it.
    if [ ! -d "$HOME/.sdkman" ]; then
        curl -s "https://get.sdkman.io" | bash
    fi
    
	source "${HOME}/.sdkman/bin/sdkman-init.sh"

	info "Installing JDK 17..."
    sdk install java 17.0.14-tem

    info "Installing JDK 21..."
    sdk install java 21.0.6-tem
}

install_packages() {
	info "Installing packages..."
	install_brew_formulas "${packages[@]}"

	info "Cleaning up brew packages..."
	brew cleanup
	
	info "Installing Java..."
	install_sdkman_and_jdks
}

