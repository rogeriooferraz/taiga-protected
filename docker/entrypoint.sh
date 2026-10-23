#!/usr/bin/env bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC

set -euo pipefail


# Start Taiga processes
echo Starting Taiga Protected

exec gosu taiga gunicorn server:app \
    --name taiga_protected \
    --bind 0.0.0.0:8003 \
    --workers 4 \
    --worker-tmp-dir /dev/shm \
    --max-requests 3600 \
    --max-requests-jitter 360 \
    --timeout 60 \
    --log-level=info \
    --access-logfile - \
    --access-logformat '%(h)s %(t)s "%(m)s %(U)s %(H)s" %(s)s %(b)s' \
    "$@"
