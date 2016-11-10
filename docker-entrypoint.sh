#!/usr/bin/env bash
set -eo pipefail

main() {
  local PIRIUM_BIN="$HOME/.composer/vendor/bin/pirum"
  # Build the pear channel from the zip files in the volume.
  pushd /data/public > /dev/null
  cp /data/pirum.xml /data/public/pirum.xml
  rm -rf /data/public/get/*tgz

  for i in *.tgz; do
    "$PIRIUM_BIN" add . "$i"
  done
  "$PIRIUM_BIN" build .
  popd > /dev/null

  nginx -g "daemon off;"
}

main "$@"
