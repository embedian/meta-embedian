FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:smarcimx8mm2g = " \
	file://0001-imx8mm-scarthgap-allocate-uart4-to-cortex-a53.patch \
"

SRC_URI:append:smarcimx8mm4g = " \
        file://0001-imx8mm-scarthgap-allocate-uart4-to-cortex-a53.patch \
"
