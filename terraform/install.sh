install_terraform() {
  brew tap hashicorp/tap
  brew install hashicorp/tap/terraform


  terraform -install-autocomplete
}

if test ! $(which terraform)

then
  install_terraform
fi