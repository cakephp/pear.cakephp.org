#!/usr/bin/env bash
set -eo pipefail

main() {
  pushd /app > /dev/null

  mkdir -p /app/get/
  find /data -maxdepth 1 -type f -name "*.tar" -exec cp {} /app/get/ \;
  find /data -maxdepth 1 -type f -name "*.tgz" -exec cp {} /app/get/ \;
  /app/pirum build .

  popd > /dev/null

  nginx -g "daemon off;"
}

main "$@"
