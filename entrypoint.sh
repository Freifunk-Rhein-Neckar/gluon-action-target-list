#!/usr/bin/env bash

set -euxo pipefail

if [ "$ACTION_GLUON_BROKEN" -eq 1 ]; then
    ACTION_GLUON_BROKEN=1
else
    # Mapping is neccesary so that it works with and without the following patch:
    # https://github.com/freifunk-gluon/gluon/pull/2934
    ACTION_GLUON_BROKEN=""
fi

# use docs site if no site repo is given, otherwise use the site repo
if [ -z "$ACTION_SITE_PATH" ]; then
    ACTION_SITE_PATH="/gluon/gluon-repo/docs/site-example"
else
    ACTION_SITE_PATH="/gluon/site-repo"
fi

GLUON_MAKE_ARGS=""
[ -n "${ACTION_GLUON_BROKEN:-}" ] && GLUON_MAKE_ARGS="${GLUON_MAKE_ARGS} BROKEN=${ACTION_GLUON_BROKEN}"
[ -n "${ACTION_GLUON_DEPRECATED:-}" ] && GLUON_MAKE_ARGS="${GLUON_MAKE_ARGS} GLUON_DEPRECATED=${ACTION_GLUON_DEPRECATED}"

ACTION_MAKE_TARGET="list-targets"

# shellcheck disable=SC2086
# Get List of available Targets
make --no-print-directory -C /gluon/gluon-repo $ACTION_MAKE_TARGET $GLUON_MAKE_ARGS "GLUON_SITEDIR=${ACTION_SITE_PATH}"
