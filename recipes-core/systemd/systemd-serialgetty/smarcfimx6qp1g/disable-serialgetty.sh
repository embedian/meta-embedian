#!/bin/sh

UART0_SERVICE=serial-getty@ttymxc0.service
UART4_SERVICE=serial-getty@ttymxc4.service

tty_service_enabled()
{
	test -f /etc/systemd/system/getty.target.wants/$1
}

som_is_smarcfimx6qp1g()
{
	grep -q smarcfimx6qp1g /sys/devices/soc0/machine
}

if som_is_smarcfimx6qp1g && tty_service_enabled ${UART0_SERVICE}; then
	systemctl stop ${UART0_SERVICE}
	systemctl disable ${UART0_SERVICE}
	systemctl enable ${UART4_SERVICE}
fi



