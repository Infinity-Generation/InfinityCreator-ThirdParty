#!/usr/bin/env bash
#
# Builds the FFmpeg shared libraries we ship with Infinity Creator on Linux.
# Release CI runs this same script, so what it produces is what we package.
# Keep it in sync with the FFmpeg step in the Linux release workflow.
#
# Usage: ./build-ffmpeg.sh [install-prefix]
set -euo pipefail

VERSION="6.1.2"
SHA256="3b624649725ecdc565c903ca6643d41f33bd49239922e45c9b1442c63dca4e38"
PREFIX="${1:-$(pwd)/ffmpeg-prefix}"
TARBALL="ffmpeg-${VERSION}.tar.xz"

cd "$(dirname "$0")"

if [ ! -f "$TARBALL" ]; then
    curl -fL --retry 3 -o "$TARBALL" "https://ffmpeg.org/releases/${TARBALL}"
fi
echo "${SHA256}  ${TARBALL}" | sha256sum -c -

rm -rf src && mkdir -p src
tar -xf "$TARBALL" -C src --strip-components=1
cd src

# Everything off, then back on only what the splash-screen decoder touches:
# H.264 in MP4, read from a file, scaled to BGRA. Few MB instead of ~20.
#
# No --enable-gpl and no --enable-nonfree; either would change the licence of
# the result and of anything linking against it. --disable-autodetect keeps
# configure from picking up whatever happens to be installed on the build box,
# which is the usual way a build ends up with GPL components by accident.
./configure \
    --prefix="$PREFIX" \
    --enable-shared --disable-static --enable-pic \
    --disable-everything --disable-autodetect \
    --enable-decoder=h264 --enable-parser=h264 \
    --enable-demuxer=mov --enable-protocol=file \
    --enable-swscale \
    --disable-programs --disable-doc --disable-avdevice \
    --disable-avfilter --disable-postproc --disable-network

make -j"$(nproc)"
make install

echo
echo "Installed to ${PREFIX}"
ls -1 "${PREFIX}/lib/"*.so.* 2>/dev/null || true
