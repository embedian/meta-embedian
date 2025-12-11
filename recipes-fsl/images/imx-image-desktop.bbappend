# Remove snapd-related packages from Ubuntu rootfs
APTGET_EXTRA_PACKAGES:remove = " \
    snapd snap-confine snapd-xdg-open \
    ubuntu-core-launcher ubuntu-core-snapd-units \
    ubuntu-snappy-cli ubuntu-snappy \
    golang-github-snapcore-snapd-dev \
    golang-github-ubuntu-core-snappy-dev \
"

ROOTFS_POSTPROCESS_COMMAND += "block_snapd_apt;"

block_snapd_apt () {
    mkdir -p ${IMAGE_ROOTFS}/etc/apt/preferences.d
    cat > ${IMAGE_ROOTFS}/etc/apt/preferences.d/nosnap.pref <<EOF
Package: snapd
Pin: release *
Pin-Priority: -1
EOF
}
