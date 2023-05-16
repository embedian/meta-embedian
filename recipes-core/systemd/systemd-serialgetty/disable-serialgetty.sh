#!/bin/sh

UART0_SERVICE=serial-getty@ttymxc0.service
UART1_SERVICE=serial-getty@ttymxc1.service
UART2_SERVICE=serial-getty@ttymxc2.service
UART3_SERVICE=serial-getty@ttymxc3.service

tty_service_enabled()
{
	test -f /etc/systemd/system/getty.target.wants/$1
}

if tty_service_enabled ${UART0_SERVICE}; then
	systemctl stop ${UART0_SERVICE}
	systemctl disable ${UART0_SERVICE}
	systemctl enable ${UART1_SERVICE}
fi



