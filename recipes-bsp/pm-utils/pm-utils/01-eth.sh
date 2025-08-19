#!/bin/sh

case $1 in

"suspend")
	if [ "$ETH_SUSPEND_MODE" = "disabled" ]; then
		# Bring down all eth interfaces for low power suspend
		for eth_interface in /sys/class/net/eth* ; do
		ifconfig $(basename ${eth_interface}) down
		done
	fi
        ;;
"resume")
	for eth_interface in /sys/class/net/eth* ; do
		ifconfig $(basename ${eth_interface}) down
		ifconfig $(basename ${eth_interface}) up
	done
	;;
esac
