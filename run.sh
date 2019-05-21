#!/usr/bin/env bash

set -e

: "${CF_API:?Need to set CF_API}"
: "${CF_PASSWORD:?Need to set CF_PASSWORD}"

CONFIG=/tmp/config.json

mkdir -p /go/src/github.com/cloudfoundry
cd /go/src/github.com/cloudfoundry
git clone https://github.com/cloudfoundry/cf-smoke-tests
cd cf-smoke-tests

APPS_DOMAIN="${CF_API/https:\/\/api.system/apps}"
cat << EOF > ${CONFIG}
{
    "suite_name": "CF_SMOKE_TESTS",
    "api": "${CF_API}",
    "apps_domain": "${APPS_DOMAIN}",
    "user": "${CF_USERNAME}",
    "password": "${CF_PASSWORD}",
    "cleanup": true,
    "logging_app": "",
    "runtime_app": "",
    "enable_windows_tests": false,
    "enable_isolation_segment_tests": false,
    "use_existing_org": true,
    "use_existing_space": true,
    "org": "${CF_ORG}",
    "space": "${CF_SPACE}"
}
EOF
CONFIG="${CONFIG}" ./bin/test
