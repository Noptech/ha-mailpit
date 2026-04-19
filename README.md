# ha-mailpit

Home Assistant add-on repository for Mailpit.

## Add-on

- `tessera-mailpit`

Published image:

- `ghcr.io/noptech/tessera-mailpit`

## Purpose

This repository packages Mailpit for Home Assistant OS so preview and testing
environments can capture SMTP mail locally and inspect it through the Mailpit
web UI and HTTP API.

## Installation

1. Open Home Assistant.
2. Go to `Settings` -> `Add-ons` -> `Add-on Store`.
3. Add this repository URL:
   `https://github.com/Noptech/ha-mailpit`
4. Install `Tessera Mailpit`.

## Access

- SMTP: `1025`
- Web UI / HTTP API: `8025`

The add-on is intended to be used behind Cloudflare Tunnel or LAN access.

## Releases

Tagged releases publish multi-arch images to GHCR and create a GitHub Release.

## Authentication

If UI basic auth credentials are not provided in add-on configuration, the
add-on generates them on first start and stores them under `/data`.

## Notes

- No real mail delivery is performed.
- Captured mail persists across restarts under `/data/mailpit.db`.
