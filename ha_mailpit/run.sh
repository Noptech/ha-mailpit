#!/usr/bin/with-contenv bashio
set -euo pipefail

AUTH_FILE="/data/mailpit-ui-auth.txt"
STORAGE_PATH="$(bashio::config 'storage_path')"
USERNAME=""
PASSWORD=""
MAX_MESSAGES="$(bashio::config 'max_messages')"
MAX_AGE_DAYS="$(bashio::config 'max_age_days')"

mkdir -p "$(dirname "${STORAGE_PATH}")"

if bashio::config.has_value 'ui_basic_auth_username'; then
  USERNAME="$(bashio::config 'ui_basic_auth_username')"
fi

if bashio::config.has_value 'ui_basic_auth_password'; then
  PASSWORD="$(bashio::config 'ui_basic_auth_password')"
fi

if [[ -n "${USERNAME}" && -n "${PASSWORD}" ]]; then
  bashio::log.info "Using configured UI basic auth credentials."
  printf '%s:%s\n' "${USERNAME}" "${PASSWORD}" > "${AUTH_FILE}"
  chmod 600 "${AUTH_FILE}"
elif [[ -z "${USERNAME}" && -z "${PASSWORD}" ]]; then
  if [[ ! -f "${AUTH_FILE}" ]]; then
    USERNAME="mailpit-$(od -An -N4 -tx1 /dev/urandom | tr -d ' \n')"
    PASSWORD="$(od -An -N16 -tx1 /dev/urandom | tr -d ' \n')"
    printf '%s:%s\n' "${USERNAME}" "${PASSWORD}" > "${AUTH_FILE}"
    chmod 600 "${AUTH_FILE}"
    bashio::log.warning "No UI basic auth credentials were configured; generated new credentials."
    bashio::log.warning "Username: ${USERNAME}"
    bashio::log.warning "Password: ${PASSWORD}"
    bashio::log.warning "Credentials are persisted in ${AUTH_FILE}."
  else
    bashio::log.info "Reusing persisted UI basic auth credentials from ${AUTH_FILE}."
  fi
else
  bashio::exit.nok "ui_basic_auth_username and ui_basic_auth_password must either both be set or both be omitted."
fi

ARGS=(
  "--database" "${STORAGE_PATH}"
  "--listen" "0.0.0.0:8025"
  "--smtp" "0.0.0.0:1025"
  "--ui-auth-file" "${AUTH_FILE}"
  "--max" "${MAX_MESSAGES}"
)

if [[ "${MAX_AGE_DAYS}" != "0" ]]; then
  ARGS+=("--max-age" "${MAX_AGE_DAYS}d")
fi

exec /usr/local/bin/mailpit "${ARGS[@]}"
