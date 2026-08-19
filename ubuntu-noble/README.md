# Ubuntu system libraries (noble)

Unmodified Debian source packages for the system libraries bundled
into the Infinity Creator Linux AppImage. `linuxdeploy` vendors these
out of the build image; two of them (systemd, libgcrypt) are LGPL, so
the corresponding source has to be available to anyone holding a
binary. The rest are here for completeness.

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
