#!/usr/bin/env bash
set -eo pipefail

main() {
  local PIRIUM_BIN="/app/pirium"
  # Build the pear channel from the zip files in the volume.
  pushd /app/public > /dev/null
  cp /app/pirum.xml /app/public/pirum.xml

  mkdir -p /app/public/get/
  rm -rf /app/public/get/*tgz

  find . -name \*.tar -maxdepth 0 -type f -exec cp {} /app/public/get/ \;
  find . -name \*.tgz -maxdepth 0 -type f -exec cp {} /app/public/get/ \;

  "$PIRIUM_BIN" build .
  popd > /dev/null

  nginx -g "daemon off;"
}

main "$@"
