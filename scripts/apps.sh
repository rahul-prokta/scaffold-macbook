apps=(
	docker
	firefox
	google-chrome
	rectangle # Window util
	slack
	visual-studio-code
	vlc # video player
	shottr # screenshot app
)

install_macos_apps() {
	info "Installing macOS apps..."
	install_brew_casks "${apps[@]}"
}
