#!/bin/sh

UART0_SERVICE=serial-getty@ttymxc0.service
UART1_SERVICE=serial-getty@ttymxc1.service

tty_service_enabled()
{
	test -f /etc/systemd/system/getty.target.wants/$1
}

som_is_smarcimx8mp4g()
{
	grep -q smarcimx8mp4g /sys/devices/soc0/machine
}

if som_is_smarcimx8mp4g && tty_service_enabled ${UART0_SERVICE}; then
	systemctl stop ${UART0_SERVICE}
	systemctl disable ${UART0_SERVICE}
	systemctl enable ${UART1_SERVICE}
fi



