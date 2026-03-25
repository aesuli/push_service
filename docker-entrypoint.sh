#!/bin/sh
set -eu

CONFIG_DIR="${PUSH_SERVICE_CONFIG_DIR:-/config}"
CONFIG_FILE="${PUSH_SERVICE_CONFIG_FILE:-${CONFIG_DIR}/push_service.yaml}"
DEFAULT_CONFIG="/app/config/push_service.yaml"

mkdir -p "${CONFIG_DIR}"

if [ -d "${CONFIG_FILE}" ]; then
  echo "ERROR: ${CONFIG_FILE} is a directory. Remove it and restart the container." >&2
  exit 1
fi

if [ ! -f "${CONFIG_FILE}" ]; then
  cp "${DEFAULT_CONFIG}" "${CONFIG_FILE}"
  echo "Created default config at ${CONFIG_FILE}"
fi

exec push_service "$@"