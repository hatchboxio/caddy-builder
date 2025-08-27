#!/bin/bash
#
# Copy to server
# bash caddy.sh latest
# bash caddy.sh branch-name
# bash caddy.sh sha

set -e

arch=$(dpkg --print-architecture)
tag=$(curl -H "Accept: application/json" -sL 'https://github.com/caddyserver/xcaddy/releases/latest' | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])")
version="${tag:1}"
go_version=$(curl https://go.dev/VERSION?m=text | head -n1)

wget "https://dl.google.com/go/$go_version.linux-$arch.tar.gz"
rm -rf /usr/local/go
tar -C /usr/local -xzf ${go_version}.linux-$arch.tar.gz
rm ${go_version}.linux-$arch.tar.gz

export PATH=$PATH:/usr/local/go/bin

wget https://github.com/caddyserver/xcaddy/releases/download/${tag}/xcaddy_${version}_linux_$arch.tar.gz
tar -xvf xcaddy_${version}_linux_$arch.tar.gz
rm xcaddy_${version}_linux_$arch.tar.gz

# Godaddy fails to compile if it's listed in alphabetical order
# panic: internal error: can't find reason for requirement on google.golang.org/appengine@v1.6.6
# panic: internal error: can't find reason for requirement on google.golang.org/pprof

./xcaddy build ${1:-latest} \
  --with github.com/caddy-dns/alidns \
  --with github.com/caddy-dns/azure \
  --with github.com/caddy-dns/bunny \
  --with github.com/caddy-dns/cloudflare \
  --with github.com/caddy-dns/digitalocean \
  --with github.com/caddy-dns/dnsimple \
  --with github.com/caddy-dns/dnspod \
  --with github.com/caddy-dns/duckdns \
  --with github.com/caddy-dns/gandi \
  --with github.com/caddy-dns/hetzner \
  --with github.com/caddy-dns/linode \
  --with github.com/caddy-dns/namecheap \
  --with github.com/caddy-dns/ovh \
  --with github.com/caddy-dns/porkbun \
  --with github.com/caddy-dns/route53 \
  --with github.com/caddy-dns/scaleway \
  --with github.com/caddy-dns/vultr \
  --with github.com/caddy-dns/godaddy \
  --with github.com/caddy-dns/googleclouddns

rm xcaddy
