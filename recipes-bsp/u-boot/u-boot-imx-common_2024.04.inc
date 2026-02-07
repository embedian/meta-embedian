DESCRIPTION = "i.MX U-Boot suppporting i.MX reference boards."

LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"
UBOOT_SRC ?= "git://github.com/embedian/smarc-uboot.git;protocol=https"
SRCBRANCH = "emb_lf_v2024.04"
LOCALVERSION ?= "-1.0.0+yocto"
SRCREV = "da86ad8a1698d17e2377cf8826ca47b10154ff29"

REAL_TIME_EDGE_UBOOT_SRC ?= "git://github.com/embedian/smarc-uboot.git;protocol=https"
REAL_TIME_EDGE_UBOOT_BRANCH ?= "emb_lf_v2024.04"
REAL_TIME_EDGE_UBOOT_SRCREV ?= "da86ad8a1698d17e2377cf8826ca47b10154ff29"

UBOOT_SRC = "${REAL_TIME_EDGE_UBOOT_SRC}"
SRCBRANCH = "${REAL_TIME_EDGE_UBOOT_BRANCH}"
SRCREV = "${REAL_TIME_EDGE_UBOOT_SRCREV}"

SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"

do_configure:prepend:real-time-edge() {
    mkdir -p ${WORKDIR}/source-date-epoch
    date '+%s' > ${WORKDIR}/source-date-epoch/__source_date_epoch.txt
}


DEPENDS += " \
    bc-native \
    bison-native \
    dtc-native \
    flex-native \
    gnutls-native \
    xxd-native \
"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"

inherit fsl-u-boot-localversion

BOOT_TOOLS = "imx-boot-tools"
