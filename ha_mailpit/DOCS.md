# ha-mailpit

Mailpit packaged as a Home Assistant add-on.

## What it is

This add-on runs Mailpit as a local SMTP capture sink with a browser UI and
HTTP API. It is intended for preview, staging, and local development email
flows.

## Ports

- `1025/TCP`: SMTP capture
- `8025/TCP`: Web UI and HTTP API

## Persistence

Captured mail is stored in `/data/mailpit.db` by default.

## Authentication

The web UI and HTTP API are protected with Mailpit basic auth.

- If `ui_basic_auth_username` and `ui_basic_auth_password` are provided, those
  credentials are used.
- If both are omitted, the add-on generates credentials on first start and
  persists them under `/data/mailpit-ui-auth.txt`.

## Configuration

- `ui_basic_auth_username`: Optional UI basic auth username.
- `ui_basic_auth_password`: Optional UI basic auth password.
- `max_messages`: Maximum number of messages to keep.
- `max_age_days`: Maximum message age in days. Set to `0` to disable age-based
  pruning.
- `storage_path`: Database path, defaults to `/data/mailpit.db`.

## Operational notes

- This add-on does not relay mail externally.
- SMTP is intentionally left open for local capture use cases.
- The add-on is safe to place behind Cloudflare Tunnel for remote preview
  access.
