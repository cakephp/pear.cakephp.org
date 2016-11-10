#!/usr/bin/env bash
set -eo pipefail

main() {
  local PIRIUM_BIN="/data/pirium"
  # Build the pear channel from the zip files in the volume.
  pushd /data/public > /dev/null
  cp /data/pirum.xml /data/public/pirum.xml

  mkdir -p /data/public/get/
  rm -rf /data/public/get/*tgz

  for i in *.tgz; do
    cp "$i" /data/public/get/
  done
  "$PIRIUM_BIN" build .
  popd > /dev/null

  nginx -g "daemon off;"
}

main "$@"
