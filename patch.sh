#!/usr/bin/env bash
set -euo pipefail

err() {
    >&2 echo "$@"
}

usage() {
    err "usage: $1 ThePathOfYourOpenRestySrcDirectory"
    exit 1
}

failed_to_cd() {
    err "failed to cd $1"
    exit 1
}

if [[ $# != 1 ]]; then
    usage "$0"
fi

if [[ $1 != *openresty-1.19.3.* ]]; then
    err "can't detect OpenResty version"
    exit 1
fi

patch="$PWD/nginx-1.19.3.patch"
dir="$1/bundle/nginx-1.19.3"
cd "$dir" || failed_to_cd "$dir"
echo "Start to patch $patch to $dir..."
patch -p0 --verbose < "$patch"
