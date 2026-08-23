# netprobe

`netprobe` is a Bash-based network diagnostics CLI for latency checks, homelabs, internet troubleshooting, and authorized network testing.

## Basic usage

```bash
./netprobe
./netprobe -f pinglist.txt -n 10
./netprobe -i
```

## Diagnostic modes

```bash
./netprobe --tcp api.kite.trade:443
./netprobe --http https://example.com
./netprobe --dns example.com
./netprobe --trace example.com
./netprobe --mtu example.com
./netprobe --info
./netprobe --speed
./netprobe --discover 192.168.1.0/24
./netprobe --security https://example.com
```

Use discovery and security features only on systems and networks you own or are authorized to test.

## Installation

```bash
cp netprobe ~/scripts/netprobe
chmod +x ~/scripts/netprobe
```

Some optional modes use platform tools such as `fzf`, `curl`, `dig`, `nc`, `traceroute`, and `openssl`.
