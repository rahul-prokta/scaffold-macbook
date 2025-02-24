#!/usr/bin/env bash

. scripts/utils.sh
. scripts/brew.sh
. scripts/apps.sh
. scripts/sshconfig.sh
. scripts/osx.sh
. scripts/packages.sh
. scripts/oh_my_zsh.sh

cleanup() {
	err "Last command failed"
	info "Finishing..."
}

wait_input() {
	read -p "Press enter to continue: "
}

main() {
	info "Installing ..."

	info "################################################################################"
	info "Homebrew Packages"
	info "################################################################################"
	wait_input
	install_packages

	success "Finished installing Homebrew packages"

	info "################################################################################"
	info "Oh-my-zsh"
	info "################################################################################"
	wait_input
	install_oh_my_zsh
	success "Finished installing Oh-my-zsh"

	info "################################################################################"
	info "MacOS Apps"
	info "################################################################################"
	wait_input
	install_macos_apps

	success "Finished installing macOS apps"

	info "################################################################################"
	info "Configuration"
	info "################################################################################"
	wait_input

	setup_osx
	success "Finished configuring MacOS defaults. NOTE: A restart is needed"

	info "################################################################################"
	info "Crating development folders"
	info "################################################################################"
	mkdir -p ~/work/prokta
	mkdir -p ~/personal

	info "################################################################################"
	info "SSH Key"
	info "################################################################################"
	setup_github_ssh
	success "Finished setting up SSH Key"

	success "Done"

	info "System needs to restart"
}

trap cleanup SIGINT SIGTERM ERR EXIT

main
