#!/usr/bin/env bash
# install.sh - Installer for wqa and weeklyquotaagy
set -euo pipefail

INSTALL_DIR="${HOME}/.agents/scripts"
mkdir -p "$INSTALL_DIR"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp "$SCRIPT_DIR/bin/weeklyquotaagy" "$INSTALL_DIR/weeklyquotaagy"
cp "$SCRIPT_DIR/bin/wqa" "$INSTALL_DIR/wqa"
chmod +x "$INSTALL_DIR/weeklyquotaagy" "$INSTALL_DIR/wqa"

echo "✓ Installed weeklyquotaagy and wqa to $INSTALL_DIR"

# Check if INSTALL_DIR is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
  echo ""
  echo "Add $INSTALL_DIR to your PATH in ~/.zshrc or ~/.bashrc:"
  echo "  export PATH=\"\$HOME/.agents/scripts:\$PATH\""
fi

echo ""
echo "Recommended shell integration for sub-millisecond execution:"
echo '  alias wqa="weeklyquotaagy"'
echo ""
echo "Try running:"
echo "  wqa"
