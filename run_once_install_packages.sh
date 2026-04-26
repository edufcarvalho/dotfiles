#!/usr/bin/env bash

set -euo pipefail

PACKAGES_FILE="/home/eduardo/.local/share/chezmoi/.packages.yaml"

log() {
  printf '[install-packages] %s\n' "$*"
}

fail() {
  log "$*"
  exit 1
}

is_cachyos() {
  [[ -r /etc/os-release ]] || return 1
  grep -Eiq '^(ID|ID_LIKE)=.*cachy' /etc/os-release
}

read_cachy_packages() {
  awk '
    /^  cachy:$/ { in_cachy = 1; next }
    in_cachy && /^  [^ ]/ { exit }
    in_cachy && /^    - / {
      pkg = $0
      sub(/^    - /, "", pkg)
      gsub(/'\''/, "", pkg)
      print pkg
    }
  ' "${PACKAGES_FILE}"
}

main() {
  [[ -f "${PACKAGES_FILE}" ]] || fail "Missing ${PACKAGES_FILE}"

  if ! is_cachyos; then
    log "Skipping package installation because this host is not CachyOS."
    exit 0
  fi

  mapfile -t packages < <(read_cachy_packages)
  (( ${#packages[@]} > 0 )) || fail "No packages found under packages.cachy in ${PACKAGES_FILE}"

  if [[ ! -t 0 ]] && ! sudo -n true >/dev/null 2>&1; then
    log "Skipping package installation because sudo requires a password in a non-interactive session."
    exit 0
  fi

  log "Installing yay"
  sudo pacman -S --needed yay-bin

  if ! command -v yay >/dev/null 2>&1; then
    fail "yay is not available after installing yay-bin."
  fi

  log "Installing ${#packages[@]} packages with yay."
  yay -S --needed "${packages[@]}"
}

main "$@"
