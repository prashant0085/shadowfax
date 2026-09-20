# shadowfax

<p align="center">
  <strong>Understand your network path, one probe at a time.</strong><br>
  A terminal-first network diagnostics toolkit for latency, APIs, homelabs, and authorized testing.
</p>

<p align="center">
  <a href="https://github.com/prashant0085/shadowfax/stargazers"><img src="https://img.shields.io/github/stars/prashant0085/shadowfax?style=flat-square" alt="GitHub stars"></a>
  <img src="https://img.shields.io/badge/shell-bash-121011?style=flat-square&logo=gnu-bash&logoColor=white" alt="Bash">
</p>

<p align="center">
  <img src="demo/shadowfax-demo-v1.svg" alt="Animated shadowfax terminal demo" width="900">
</p>

`shadowfax` began as a small parallel `ping` dashboard for comparing a home router, public DNS providers, market-data endpoints, and arbitrary hosts. It is growing into a practical toolkit for developers, homelab operators, SREs, and authorized security testers.

## Highlights

- Parallel ICMP checks with packet loss, min/average/max latency, and jitter
- TCP port reachability and HTTP DNS/TCP/TLS/TTFB timing
- DNS resolver comparisons, traceroute, MTU, and IPv4/IPv6 diagnostics
- Live interactive `fzf` dashboard and continuous watch mode
- CSV/JSON output and latency/loss thresholds for automation
- Local interface, gateway, DNS, and public-IP inspection
- Platform internet-speed testing and authorized `/24` discovery
- HTTP security headers and TLS certificate-date checks

## Install

### One-line install

Install the latest version into `~/.local/bin` without `sudo`:

```bash
curl -fsSL https://raw.githubusercontent.com/prashant0085/shadowfax/main/install.sh | bash
```

To install into a custom location instead (e.g. `~/scripts`), set `SHADOWFAX_INSTALL_DIR`:

```bash
curl -fsSL https://raw.githubusercontent.com/prashant0085/shadowfax/main/install.sh | SHADOWFAX_INSTALL_DIR=~/scripts bash
```

Then run:

```bash
shadowfax
```

If `~/.local/bin` is not in your `PATH`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

### Review before installing

```bash
curl -fsSL https://raw.githubusercontent.com/prashant0085/shadowfax/main/install.sh -o /tmp/shadowfax-install.sh
less /tmp/shadowfax-install.sh
bash /tmp/shadowfax-install.sh
```

### From source

```bash
git clone https://github.com/prashant0085/shadowfax.git
cd shadowfax
mkdir -p ~/.local/bin
cp shadowfax ~/.local/bin/shadowfax
chmod +x ~/.local/bin/shadowfax
```

## Quick start

Run the built-in checks:

```bash
shadowfax
```

Test endpoints from a file, with ten probes per endpoint:

```bash
shadowfax -f pinglist.txt -n 10
```

Open the live interactive dashboard:

```bash
shadowfax -i -f pinglist.txt -n 10
```

Use `q` or `Esc` to close the interactive view. Interactive mode requires [`fzf`](https://github.com/junegunn/fzf#installation).

## Examples

### Trading and API latency

```bash
shadowfax --http https://api.kite.trade
shadowfax --tcp api.kite.trade:443
shadowfax --dns api.kite.trade
shadowfax --trace api.kite.trade
```

ICMP measures the network path. HTTP timing measures what an API client actually experiences:

```text
DNS -> TCP -> TLS -> time to first byte -> total request time
```

### Homelab diagnostics

```bash
shadowfax --info
shadowfax --discover 192.168.1.0/24
shadowfax --mtu 192.168.1.1
shadowfax -4
shadowfax -6
```

### Monitoring and automation

Refresh every five seconds:

```bash
shadowfax --watch 5
```

Return exit code `3` if thresholds are exceeded:

```bash
shadowfax -f pinglist.txt -n 10 --max-avg 50 --max-loss 2
```

Export results:

```bash
shadowfax -f pinglist.txt -n 10 --csv
shadowfax -f pinglist.txt -n 10 --json
```

### Other diagnostics

```bash
shadowfax --speed
shadowfax --security https://example.com
shadowfax --help
```

## Endpoint files

Pass one hostname or IP per line. Blank lines and comments are ignored:

```text
google.com
1.1.1.1
api.kite.trade
192.168.1.20
```

## Optional dependencies

The basic ICMP dashboard requires Bash and `ping`. Optional modes use tools available on the host:

| Tool | Used for |
| --- | --- |
| `fzf` | Interactive dashboard |
| `curl` | HTTP timing, public IP, security checks |
| `dig` | DNS benchmarking |
| `nc` | TCP checks |
| `traceroute` | Route diagnostics |
| `openssl` | TLS certificate inspection |
| `networkQuality` | macOS internet-speed testing |

Missing optional dependencies are reported only when their corresponding mode is used.

## Responsible use

Use discovery, TCP checks, and security diagnostics only on systems and networks you own or are explicitly authorized to test. `shadowfax` is intended for diagnostics and defensive administration; it does not bypass authentication or exploit services.

## Project status

`shadowfax` is actively evolving. Ideas and contributions are welcome as the command surface becomes more portable and the output becomes easier to integrate with monitoring systems.

### TODO

- Replace the illustrative animated SVG with a recorded terminal demo, preferably an animated GIF or equivalent terminal recording similar to the demo used by [`kube-ps1`](https://github.com/jonmosco/kube-ps1).

## License

This project is currently under active development. A formal open-source license will be added before the first stable release.
