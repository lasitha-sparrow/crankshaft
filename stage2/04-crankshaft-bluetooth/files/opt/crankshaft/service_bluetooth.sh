#!/bin/bash

source /opt/crankshaft/crankshaft_default_env.sh
source /opt/crankshaft/crankshaft_system_env.sh

if [ $ENABLE_BLUETOOTH -eq 1 ]; then
    touch /tmp/button_bluetooth_visible
    # only disable wifi if system is in normal mode
    if [ $DEV_MODE -eq 0 ] && [ ! -f /tmp/usb_dev_mode ] && [ ! -f /tmp/usb_debug_mode ] && [ ! -f /tmp/dev_mode_enabled ]; then
        sudo ifconfig wlan0 down > /dev/null 2>&1
    fi

    # Set controller in correct mode
    sudo bt-adapter --set Powered 1
    sudo bt-adapter --set DiscoverableTimeout 0
    sudo bt-adapter --set Discoverable 1
    sudo bt-adapter --set PairableTimeout 120
    if [ $ENABLE_PAIRABLE -eq 1 ]; then
        sudo bt-adapter --set Pairable 1
    else
        sudo bt-adapter --set Pairable 0
    fi
fi