SECTION = "kernel"
DESCRIPTION = "Linux kernel for SMARC-T437X Computer on Modules"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"

inherit kernel

require recipes-kernel/linux/linux-dtb.inc
require recipes-kernel/linux/setup-defconfig.inc
require recipes-kernel/linux/cmem.inc
require recipes-kernel/linux/ti-uio.inc

# Look in the generic major.minor directory for files
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-4.9:"

# Pull in the devicetree files into the rootfs
RDEPENDS_kernel-base += "kernel-devicetree"

# Add a run-time dependency for the PM firmware to the rootfs
# on the target file system.
RDEPENDS_kernel-base_append_ti33x = " amx3-cm3"
RDEPENDS_kernel-base_append_ti43x = " amx3-cm3"

# Add a run-time dependency for the VPE VPDMA firmware to the rootfs
RDEPENDS_kernel-base_append_dra7xx = " vpdma-fw"

# Add run-time dependency for Goodix firmware to the rootfs
RDEPENDS_kernel-base_append_dra7xx = " goodix-fw"

# Install boot-monitor skern file into /boot dir of rootfs
RDEPENDS_kernel-base_append_keystone = " boot-monitor"

# Install ti-sci-fw into /boot dir of rootfs
RDEPENDS_kernel-base_append_k2g = " ti-sci-fw"

# Add run-time dependency for SerDes firmware to the rootfs
RDEPENDS_kernel-base_append_keystone = " serdes-fw"

# Add run-time dependency for QMSS PDSP firmware to the rootfs
RDEPENDS_kernel-base_append_keystone = " qmss-pdsp-fw"

# Add run-time dependency for NETCP PA firmware to the rootfs
RDEPENDS_kernel-base_append_k2hk = " netcp-pa-fw"
RDEPENDS_kernel-base_append_k2e = " netcp-pa-fw"
RDEPENDS_kernel-base_append_k2l-evm = " netcp-pa-fw"

KERNEL_EXTRA_ARGS += "LOADADDR=${UBOOT_ENTRYPOINT}"

S = "${WORKDIR}/git"

BRANCH = "smarct4x-processor-sdk-04.01.00.06"

SRCREV = "a81260738c943b13c31d3627faff98284a0da5d0"
PV = "4.9.41+git${SRCPV}"

# Append to the MACHINE_KERNEL_PR so that a new SRCREV will cause a rebuild
MACHINE_KERNEL_PR_append = "c"
PR = "${MACHINE_KERNEL_PR}"

SRC_URI = "${EMB_KERNEL_MIRROR};protocol=ssh;branch=${BRANCH} \
        file://defconfig \
"
