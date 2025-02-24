setup_github_ssh() {
	info "Follow the steps and create ssh keys"
	ssh-keygen -t ed25519

	info "Adding ssh key to keychain"
	ssh-add -K ~/.ssh/id_ed25519

	info "Remember add ssh key to github account 'pbcopy < ~/.ssh/id_ed25519.pub'"
}
