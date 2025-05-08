#!/bin/bash

set -e

PLUGIN_NAME="kubectl-debugpod"
INSTALL_DIR="/usr/local/bin"
REPO_URL="https://raw.githubusercontent.com/gyarlabs/kubernetes-helper/main/${PLUGIN_NAME}"

echo "Installing ${PLUGIN_NAME}..."

if [[ ! -w "$INSTALL_DIR" ]]; then
  echo " No permission on user to save files to ${INSTALL_DIR}. Try running with sudo."
  exit 1
fi

curl -fsSL "$REPO_URL" -o "${INSTALL_DIR}/${PLUGIN_NAME}"
chmod +x "${INSTALL_DIR}/${PLUGIN_NAME}"

echo " ${PLUGIN_NAME} installed to ${INSTALL_DIR}/${PLUGIN_NAME}"
echo "ℹ  Run 'kubectl debugpod --help' to get started."
