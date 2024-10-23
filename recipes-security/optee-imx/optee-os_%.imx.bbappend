FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:smarcimx8mq4g = " file://0001-imx-imx8mq-add-support-more-than-3GB.patch"
SRC_URI:append:smarcimx8mm4g = " file://0001-imx-imx8mm-add-support-more-than-3GB.patch"

EXTRA_OEMAKE:append:ismarcimx8mq4g = " \
    CFG_DDR_SIZE=${TEE_CFG_DDR_SIZE} \
    CFG_TZDRAM_START=${TEE_LOAD_ADDR} \
"

EXTRA_OEMAKE:append:smarcimx8mp4g = " \
    CFG_DDR_SIZE=${TEE_CFG_DDR_SIZE} \
"

EXTRA_OEMAKE:append:smarcimx8mp6g = " \
    CFG_DDR_SIZE=${TEE_CFG_DDR_SIZE} \
"

EXTRA_OEMAKE:append:pitximx8mp4g = " \
    CFG_DDR_SIZE=${TEE_CFG_DDR_SIZE} \
"

EXTRA_OEMAKE:append:pitximx8mp6g = " \
    CFG_DDR_SIZE=${TEE_CFG_DDR_SIZE} \
"

EXTRA_OEMAKE:append:smarcimx8mm4g = " \
    CFG_DDR_SIZE=${TEE_CFG_DDR_SIZE} \
    CFG_TZDRAM_START=${TEE_LOAD_ADDR} \
"
