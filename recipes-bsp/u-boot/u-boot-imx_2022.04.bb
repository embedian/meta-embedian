# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2018 (C) O.S. Systems Software LTDA.
# Copyright 2017-2022 NXP
# Copyright 2023 Embedian

require recipes-bsp/u-boot/u-boot.inc
require recipes-bsp/u-boot/u-boot-imx-common_${PV}.inc

###############################################################
# BEGIN: Changes to u-boot-imx-common_${PV}.inc

LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

# Use Github as U-Boot source repo
# UBOOT_SRC ?= "git://github.com/embedian/smarc-uboot.git;protocol=https"
UBOOT_SRC ?= "git://git@git.embedian.com/developer/smarc-t335x-uboot.git;protocol=ssh"
SRCBRANCH = "emb_lf_v2022.04"
SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"
SRCREV = "d37704c6b2b2ea9253773a888804eebc5ea4b2c7"
LOCALVERSION = "-1.0.0+yocto"

DEPENDS += "gnutls-native xxd-native"

# END: Changes to u-boot-imx-common_${PV}.inc
###############################################################

PROVIDES += "u-boot"

inherit uuu_bootloader_tag

UUU_BOOTLOADER             = ""
UUU_BOOTLOADER:mx6-nxp-bsp = "${UBOOT_BINARY}"
UUU_BOOTLOADER:mx7-nxp-bsp = "${UBOOT_BINARY}"
UUU_BOOTLOADER_TAGGED             = ""
UUU_BOOTLOADER_TAGGED:mx6-nxp-bsp = "u-boot-tagged.${UBOOT_SUFFIX}"
UUU_BOOTLOADER_TAGGED:mx7-nxp-bsp = "u-boot-tagged.${UBOOT_SUFFIX}"

do_deploy:append:mx8m-nxp-bsp() {
    # Deploy u-boot-nodtb.bin and fsl-imx8m*-XX.dtb for mkimage to generate boot binary
    if [ -n "${UBOOT_CONFIG}" ]
    then
        for config in ${UBOOT_MACHINE}; do
            i=$(expr $i + 1);
            for type in ${UBOOT_CONFIG}; do
                j=$(expr $j + 1);
                if [ $j -eq $i ]
                then
                    install -d ${DEPLOYDIR}/${BOOT_TOOLS}
                    install -m 0777 ${B}/${config}/arch/arm/dts/${UBOOT_DTB_NAME}  ${DEPLOYDIR}/${BOOT_TOOLS}
                    install -m 0777 ${B}/${config}/u-boot-nodtb.bin  ${DEPLOYDIR}/${BOOT_TOOLS}/u-boot-nodtb.bin-${MACHINE}-${type}
                fi
            done
            unset  j
        done
        unset  i
    fi
}

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(mx6-generic-bsp|mx7-generic-bsp|mx8-generic-bsp|mx9-generic-bsp)"
