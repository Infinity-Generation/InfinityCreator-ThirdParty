# FFmpeg

`ffmpeg-6.1.2.tar.xz` is the upstream release our Linux builds link against,
unmodified. No patches.

    sha256    3b624649725ecdc565c903ca6643d41f33bd49239922e45c9b1442c63dca4e38
    upstream  https://ffmpeg.org/releases/ffmpeg-6.1.2.tar.xz

## Licence

LGPL-2.1-or-later. `build-ffmpeg.sh` passes neither `--enable-gpl` nor
`--enable-nonfree`, so nothing GPL-only gets compiled in. Full text is in
`COPYING.LGPLv2.1` inside the tarball.

Worth knowing: several distros ship a GPL-enabled "extra" flavour of FFmpeg
under the same soname. This isn't that.

## Why we bundle it

The soname major changes between distros and between releases of the same
distro — Ubuntu 24.04 has `libavcodec.so.60`, Fedora 42 `.so.61`, Tumbleweed
`.so.62`. We publish one `.deb` and one `.rpm` for everyone, and the soname is
the ABI contract, so anything built against one of those won't install on the
others.

## Using your own build

The libraries are dynamically linked and ship unmodified in:

    <install prefix>/lib/infinitycreator/lib/

Drop in any interface-compatible build and the app will use it. The executable
finds them through an `$ORIGIN`-relative RPATH, so there's no `LD_LIBRARY_PATH`
to set.

## Building

    ./build-ffmpeg.sh /tmp/ffmpeg-prefix

Needs nasm (or yasm), a C compiler and make. The `lib/libav*.so.*` and
`lib/libsw*.so.*` it produces are what we package.
