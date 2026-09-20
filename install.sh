#!/usr/bin/env bash

set -euo pipefail

repo_url="${SHADOWFAX_REPO_URL:-https://raw.githubusercontent.com/prashant0085/shadowfax/main/shadowfax}"
install_dir="${SHADOWFAX_INSTALL_DIR:-$HOME/.local/bin}"
target="$install_dir/shadowfax"
temporary_file="$(mktemp "${TMPDIR:-/tmp}/shadowfax.XXXXXX")"

cleanup() {
  rm -f "$temporary_file"
}
trap cleanup EXIT INT TERM

if ! command -v curl >/dev/null 2>&1; then
  echo "Error: curl is required to install shadowfax." >&2
  exit 1
fi

echo "Downloading shadowfax..."
curl -fsSL "$repo_url" -o "$temporary_file"

if ! head -n 1 "$temporary_file" | grep -q '^#!/usr/bin/env bash'; then
  echo "Error: downloaded file did not look like the shadowfax executable." >&2
  exit 1
fi

mkdir -p "$install_dir"
install -m 0755 "$temporary_file" "$target"

echo "Installed shadowfax to $target"
case ":${PATH}:" in
  *":$install_dir:"*) ;;
  *) echo "Add it to your PATH with: export PATH=\"$install_dir:\$PATH\"" ;;
esac
