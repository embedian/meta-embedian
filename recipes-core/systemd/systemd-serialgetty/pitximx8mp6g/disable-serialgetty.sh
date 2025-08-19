#!/bin/sh

UART0_SERVICE=serial-getty@ttymxc0.service
UART3_SERVICE=serial-getty@ttymxc3.service

tty_service_enabled()
{
	test -f /etc/systemd/system/getty.target.wants/$1
}

som_is_pitximx8mp6g()
{
	grep -q pitximx8mp6g /sys/devices/soc0/machine
}

if som_is_pitximx8mp6g && tty_service_enabled ${UART0_SERVICE}; then
	systemctl stop ${UART0_SERVICE}
	systemctl disable ${UART0_SERVICE}
	systemctl enable ${UART3_SERVICE}
fi



