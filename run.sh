#!/usr/bin/env bash

set -e

APPS_DOMAIN="${CF_API_TEST/https:\/\/api.system/apps}"    

mkdir -p /go/src/github.com/cloudfoundry
cd /go/src/github.com/cloudfoundry
git clone https://github.com/cloudfoundry/cf-smoke-tests
cd cf-smoke-tests

CONFIG=/tmp/config.json
cat << EOF > ${CONFIG}
{
    "suite_name": "CF_SMOKE_TESTS",
    "api": "${CF_API_TEST}",
    "apps_domain": "${APPS_DOMAIN}",
    "user": "${CF_USER}",
    "password": "${CF_PASSWORD_TEST}",
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