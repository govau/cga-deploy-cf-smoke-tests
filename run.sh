#!/usr/bin/env bash

set -e

CONFIG=/tmp/config.json

mkdir -p /go/src/github.com/cloudfoundry
cd /go/src/github.com/cloudfoundry
git clone https://github.com/cloudfoundry/cf-smoke-tests
cd cf-smoke-tests

# STAGING
APPS_DOMAIN="${CF_API_STAGING/https:\/\/api.system/apps}"
cat << EOF > ${CONFIG}
{
    "suite_name": "CF_SMOKE_TESTS",
    "api": "${CF_API_STAGING}",
    "apps_domain": "${APPS_DOMAIN}",
    "user": "${CF_USER}",
    "password": "${CF_PASSWORD_STAGING}",
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

# PROD
APPS_DOMAIN="${CF_API_PROD/https:\/\/api.system/apps}"
cat << EOF > ${CONFIG}
{
    "suite_name": "CF_SMOKE_TESTS",
    "api": "${CF_API_PROD}",
    "apps_domain": "${APPS_DOMAIN}",
    "user": "${CF_USER}",
    "password": "${CF_PASSWORD_PROD}",
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