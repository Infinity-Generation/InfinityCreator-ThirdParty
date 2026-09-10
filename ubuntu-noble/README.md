# Ubuntu system libraries (noble)

Unmodified Debian source packages for the system libraries bundled
into the Infinity Creator Linux AppImage. `linuxdeploy` vendors these
out of the build image. None of the current set is LGPL, so they are
published for completeness rather than obligation.

Earlier releases also bundled systemd and libgcrypt, which are
LGPL-2.1. Their corresponding source remains in this repository's
history; each commit's `MANIFEST.txt` names the release that
published it and the exact versions it carried.

These are not built by us and carry no patches. `MANIFEST.txt` records
which shared object came from which source package and version, and
the archive snapshot the build was pinned to.

## Rebuilding

On Ubuntu 24.04 (noble), for any package here:

    dpkg-source -x <package>_<version>.dsc
    cd <package>-<upstream-version>
    sudo apt-get build-dep <package>
    dpkg-buildpackage -us -uc -b

The build is pinned to an archive snapshot, so the exact versions
named in `MANIFEST.txt` remain installable:

    deb https://snapshot.ubuntu.com/ubuntu/<snapshot> noble main restricted universe multiverse
