# ha-mailpit

Mailpit packaged as a Home Assistant add-on.

## About

This add-on runs Mailpit as a local SMTP capture service with a web inbox and
HTTP API. It is intended for development, preview, and staging email workflows
where messages should be captured instead of delivered externally.

## Ports

- `1025/TCP`: SMTP capture endpoint
- `8025/TCP`: Web UI and HTTP API

## Authentication

The Mailpit web UI and HTTP API are protected with basic auth.

If no credentials are configured, the add-on generates credentials on first
start and writes them to the add-on log.
