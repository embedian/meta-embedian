#!/bin/sh

UART0_SERVICE=serial-getty@ttymxc0.service
UART2_SERVICE=serial-getty@ttymxc2.service

tty_service_enabled()
{
	test -f /etc/systemd/system/getty.target.wants/$1
}

som_is_smarcfimx7s()
{
	grep -q smarcfimx7s /sys/devices/soc0/machine
}

if som_is_smarcfimx7s && tty_service_enabled ${UART0_SERVICE}; then
	systemctl stop ${UART0_SERVICE}
	systemctl disable ${UART0_SERVICE}
	systemctl enable ${UART2_SERVICE}
fi



