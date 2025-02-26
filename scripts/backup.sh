#! /bin/bash -eu

BACKUP_DIR="./@backup"
BACKUP_FILENAME="${BACKUP_DIR}/backup-$(date '+%Y%m%d').tar"

PROJ_PATH="$(realpath "$(cd "$(dirname "$(realpath "$0")")" && cd ../.. && pwd)")"

cd "${PROJ_PATH}"

USR_GID="$1"
shift
USR_UID="$1"
shift

set -eux

systemctl stop docker.service
mkdir -p "${BACKUP_DIR}"
rm -f "${BACKUP_FILENAME}"
tar -cvf "${BACKUP_FILENAME}" "$@"
chown "${USR_GID}:${USR_UID}" "${BACKUP_FILENAME}"
systemctl start docker.service
