# Caddy Builder

This script compiles [Caddy releases](https://github.com/caddyserver/caddy/releases) for use with Hatchbox.io. It includes the plugins needed for SSL support with the supported DNS providers. You can also specify the version of Caddy you want to compile.

## Usage

GitHub Actions are configured to compile Caddy on Ubuntu for x86 and ARM. The workflow will compile and upload the final build to GitHub releases.

To run this manually:

```bash
# Copy the script to the host you want to build on
scp caddy.sh root@host:~

# Compile the latest version
ssh root@host "bash caddy.sh latest"

# Compile a specific version
ssh root@host "bash caddy.sh v2.11.3"
```
