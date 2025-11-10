#!/usr/bin/env bash
set -euo pipefail
/usr/local/bin/generate_routes.sh "bird-2.16.1" "192.0.2.23" "2001:db8:100::23" "192.0.2.25" "2001:db8:100::25"
