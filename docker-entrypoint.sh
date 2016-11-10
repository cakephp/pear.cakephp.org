#!/usr/bin/env bash
set -eo pipefail

main() {
  # Build the pear channel from the zip files in the volume.
  pushd /data/public > /dev/null
  cp /data/pirum.xml /data/public/pirum.xml
  ../vendor/bin/pirum build .
  popd > /dev/null

  nginx -g "daemon off;"
}

main "$@"
