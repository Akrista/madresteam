#!/usr/bin/with-contenv sh

set -u # Treat unset variables as an error.

trap "exit" TERM QUIT INT
trap "kill_steam" EXIT

log() {
    echo "[steam] $*"
}

kill_steam() {
    PID="$(pgrep steam)"
    if [ "$PID" != "" ]; then
        log "Terminating Steam..."
        kill $PID
        wait $PID
    fi
}

if [ -z "${HOME+x}" ]; then
    export HOME=/steam
fi

if [ -z "${LD_LIBRARY_PATH+x}" ]; then
    export LD_LIBRARY_PATH="/steam/xdg/data/Steam/ubuntu12_32"
fi

log "Starting Steam..."
exec steam >/dev/null 2>&1 &
