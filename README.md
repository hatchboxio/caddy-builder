# Caddy Builder

This script compiles Caddy for use with Hatchbox.io.

Primarily, it includes the plugins needed for SSL support with the supported DNS providers.

It also allows you to specify the version of Caddy you want to compile. This is useful for testing prereleases and other things.

## Usage

```bash
scp caddy.sh user@host:~
ssh user@host
bash caddy.sh
```