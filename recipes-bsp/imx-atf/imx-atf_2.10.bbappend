FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:smarcimx8mm2g = " \
	file://0001-imx8mm-scarthgap-allocate-uart4-to-cortex-a53.patch \
"

SRC_URI:append:smarcimx8mm4g = " \
        file://0001-imx8mm-scarthgap-allocate-uart4-to-cortex-a53.patch \
"

SRC_URI:append:pitximx8mp2g = " \
        file://0001-imx8mp-pitx-change-scarthgap-console-port-to-ttymxc3.patch \
"

SRC_URI:append:pitximx8mp4g = " \
        file://0001-imx8mp-pitx-change-scarthgap-console-port-to-ttymxc3.patch \
"

SRC_URI:append:pitximx8mp6g = " \
        file://0001-imx8mp-pitx-change-scarthgap-console-port-to-ttymxc3.patch \
"
