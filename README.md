# netprobe

`netprobe` is a lightweight, terminal-first network diagnostics tool for understanding latency, reachability, service connectivity, internet performance, and homelab health.

It started as a simple parallel `ping` dashboard for comparing a local router, public DNS providers, market-data endpoints, and arbitrary hosts. It is designed to grow into a practical network troubleshooting toolkit for developers, homelab operators, SREs, and authorized security testers.

## What it can do

- Compare ICMP latency across multiple endpoints in parallel
- Report packet loss, minimum/average/maximum latency, and jitter
- Test TCP port reachability
- Measure HTTP DNS, TCP, TLS, TTFB, and total request timing
- Compare DNS resolver response times
- Run traceroute and MTU diagnostics
- Force IPv4 or IPv6 checks
- Monitor endpoints continuously with watch mode
- Enforce latency and packet-loss thresholds for automation
- Export results as CSV or JSON
- Inspect local interfaces, gateways, DNS servers, and public IPs
- Run platform internet-speed tests
- Discover responsive hosts on an authorized local `/24` network
- Inspect HTTP security headers and TLS certificate dates
- Display a live interactive dashboard using `fzf`

## Quick install

Install the latest version into `~/.local/bin`:

```bash
curl -fsSL https://raw.githubusercontent.com/prashant0085/netprobe/main/install.sh | bash
```

Then run:

```bash
netprobe
```

The installer does not require `sudo`. If `~/.local/bin` is not in your `PATH`, add it:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

For a safer review-before-install workflow:

```bash
curl -fsSL https://raw.githubusercontent.com/prashant0085/netprobe/main/install.sh -o /tmp/netprobe-install.sh
less /tmp/netprobe-install.sh
bash /tmp/netprobe-install.sh
```

## Install from a clone

```bash
git clone https://github.com/prashant0085/netprobe.git
cd netprobe
mkdir -p ~/.local/bin
cp netprobe ~/.local/bin/netprobe
chmod +x ~/.local/bin/netprobe
```

## Basic usage

Run the built-in endpoint set:

```bash
netprobe
```

Test additional endpoints from a file. Use one hostname or IP per line; blank lines and comments are ignored:

```bash
netprobe -f pinglist.txt -n 10
```

Run an interactive live dashboard:

```bash
netprobe -i -f pinglist.txt -n 10
```

Interactive mode requires [`fzf`](https://github.com/junegunn/fzf#installation).

## Diagnostic modes

```bash
# TCP service reachability
netprobe --tcp api.kite.trade:443

# Real application/API timing
netprobe --http https://api.kite.trade

# DNS resolver comparison
netprobe --dns example.com

# Route inspection
netprobe --trace example.com

# Path MTU investigation
netprobe --mtu example.com

# Local interface, gateway, DNS, and public IP details
netprobe --info

# Platform internet-speed test
netprobe --speed

# Authorized local-network discovery
netprobe --discover 192.168.1.0/24

# HTTP security headers and TLS certificate dates
netprobe --security https://example.com
```

## Monitoring and automation

Refresh the default dashboard every five seconds:

```bash
netprobe --watch 5
```

Fail with exit code `3` when thresholds are exceeded:

```bash
netprobe -f pinglist.txt -n 10 --max-avg 50 --max-loss 2
```

Export results:

```bash
netprobe -f pinglist.txt -n 10 --csv
netprobe -f pinglist.txt -n 10 --json
```

Force a protocol family:

```bash
netprobe -4
netprobe -6
```

See all options:

```bash
netprobe --help
```

## Optional dependencies

The basic ICMP dashboard requires Bash and `ping`. Optional features may use:

- `fzf` for interactive mode
- `curl` for HTTP timing, public IP, and security checks
- `dig` for DNS benchmarking
- `nc`/Netcat for TCP checks
- `traceroute` for route diagnostics
- `openssl` for TLS certificate inspection
- macOS `networkQuality` for the speed test

Missing optional dependencies are reported only when their corresponding mode is used.

## Security and responsible use

Use discovery, TCP checks, and security diagnostics only on systems and networks you own or are explicitly authorized to test. `netprobe` is intended for diagnostics and defensive administration; it does not bypass authentication or exploit services.

## License

This project is currently under active development. A formal open-source license will be added before the first stable release.
