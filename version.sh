#!/usr/bin/env bash

DESC=($(git describe --match 'v*' 2>/dev/null | sed "s/v\([0-9\.]*\)-*\([0-9]*\)-*\([0-9a-z]*\)/\1 \2 \3/")) 

VERSION=($(echo ${DESC[0]} | tr "." " "))
VERSION_MAJ=${VERSION[0]}
VERSION_MIN=${VERSION[1]}
VERSION_REV=${VERSION[2]}

# get the number of commits since the last tag
COMMITS=${DESC[1]}
if [ -z "${COMMITS}" ]; then
    COMMITS="0"
fi;

VERSION="${VERSION_MAJ}.${VERSION_MIN}"

if [ "${VERSION_REV}" ]; then
    VERSION="${VERSION}.${VERSION_REV}"
fi

VERSION="${VERSION}.${COMMITS}"

echo ${VERSION}
