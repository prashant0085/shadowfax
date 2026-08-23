#!/usr/bin/env bash

set -euo pipefail

repo_url="${NETPROBE_REPO_URL:-https://raw.githubusercontent.com/prashant0085/netprobe/main/netprobe}"
install_dir="${NETPROBE_INSTALL_DIR:-$HOME/.local/bin}"
target="$install_dir/netprobe"
temporary_file="$(mktemp "${TMPDIR:-/tmp}/netprobe.XXXXXX")"

cleanup() {
  rm -f "$temporary_file"
}
trap cleanup EXIT INT TERM

if ! command -v curl >/dev/null 2>&1; then
  echo "Error: curl is required to install netprobe." >&2
  exit 1
fi

echo "Downloading netprobe..."
curl -fsSL "$repo_url" -o "$temporary_file"

if ! head -n 1 "$temporary_file" | grep -q '^#!/usr/bin/env bash'; then
  echo "Error: downloaded file did not look like the netprobe executable." >&2
  exit 1
fi

mkdir -p "$install_dir"
install -m 0755 "$temporary_file" "$target"

echo "Installed netprobe to $target"
case ":${PATH}:" in
  *":$install_dir:"*) ;;
  *) echo "Add it to your PATH with: export PATH=\"$install_dir:\$PATH\"" ;;
esac
