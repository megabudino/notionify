#!/usr/bin/env bash

usage() {
  echo "Usage: notionify.sh <markdown-file.md>"
}

error_exit() {
  echo "Error: $1"
  exit 1
}

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return 0
  fi

  echo "Homebrew not found. Installing Homebrew..."
  if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
    error_exit "Failed to install Homebrew."
  fi

  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

install_package_macos() {
  install_homebrew
  echo "Installing $1 via Homebrew..."
  if ! brew install "$1"; then
    error_exit "Failed to install $1."
  fi
}

install_package_apt() {
  echo "Installing $1 via apt-get..."
  if ! sudo apt-get update; then
    error_exit "Failed to update apt-get."
  fi
  if ! sudo apt-get install -y "$1"; then
    error_exit "Failed to install $1."
  fi
}

install_package_yum() {
  echo "Installing $1 via yum..."
  if ! sudo yum install -y "$1"; then
    error_exit "Failed to install $1."
  fi
}

install_package() {
  local package="$1"
  local os_name

  os_name=$(uname)
  case "$os_name" in
    Darwin)
      install_package_macos "$package"
      ;;
    Linux)
      if command -v apt-get >/dev/null 2>&1; then
        install_package_apt "$package"
      elif command -v yum >/dev/null 2>&1; then
        install_package_yum "$package"
      else
        error_exit "Unsupported Linux package manager."
      fi
      ;;
    *)
      error_exit "Unsupported OS: $os_name"
      ;;
  esac
}

ensure_dependency() {
  local command_name="$1"
  local package_name="$2"

  if command -v "$command_name" >/dev/null 2>&1; then
    echo "$package_name already installed."
    return 0
  fi

  echo "$package_name not found. Installing..."
  install_package "$package_name"
  if ! command -v "$command_name" >/dev/null 2>&1; then
    error_exit "$package_name installation failed."
  fi
}

if [ "$#" -ne 1 ]; then
  usage
  exit 1
fi

input_file="$1"

if [[ "$input_file" != *.md ]]; then
  echo "Error: input file must have a .md extension."
  exit 1
fi

if [ ! -f "$input_file" ]; then
  echo "Error: '$input_file' not found in current directory."
  exit 1
fi

ensure_dependency "pandoc" "pandoc"
ensure_dependency "wkhtmltopdf" "wkhtmltopdf"

echo "Input validated: $input_file"
exit 0
