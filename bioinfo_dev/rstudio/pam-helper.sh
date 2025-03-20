#!/bin/bash
set -o nounset

## https://github.com/rocker-org/rocker-versioned2/blob/master/scripts/pam-helper.sh

## Enforces the custom password specified in the PASSWORD environment variable
## The accepted RStudio username is the same as the USER environment variable (i.e., local user name).

IFS='' read -r password

[ "${USER}" = "${1}" ] && [ "${PASSWORD}" = "${password}" ]

