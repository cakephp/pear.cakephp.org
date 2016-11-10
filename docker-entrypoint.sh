#!/usr/bin/env bash
set -eo pipefail

main() {
  # Build the pear channel from the zip files in the volume.
  pushd /data/public > /dev/null
  cp /data/pirum.xml /data/public/pirum.xml
  rm -rf /data/public/get/*tgz
  for i in *.tgz; do
    ../vendor/bin/pirum add . "$i"
  done
  ../vendor/bin/pirum build .
  popd > /dev/null

  nginx -g "daemon off;"
}

main "$@"
