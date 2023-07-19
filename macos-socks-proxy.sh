#!/bin/sh

PROXY_INTERFACE="Wi-Fi"
PROXY_HOST="127.0.0.1"
PROXY_PORT=9090

if [[ $1 == "on" ]]; then
        
    # Check that ssh command is running
    if [[ $(ps aux | grep ssh | grep $PROXY_PORT | wc -l | xargs) != 1 ]]; then
        echo "ERROR: No ssh tunnel detected on port $PROXY_PORT"
        exit 1
    fi
    sudo networksetup -setsocksfirewallproxy "$PROXY_INTERFACE" $PROXY_HOST $PROXY_PORT
    echo "SOCKS proxy enabled"

elif [[ $1 == "off" ]]; then
    sudo networksetup -setsocksfirewallproxystate "$PROXY_INTERFACE" off
    echo "SOCKS proxy disabled"

elif [[ $1 == "status" ]]; then
    echo "======================================================"
    echo "Network Services:"
    echo "======================================================"
    networksetup -listallnetworkservices
    echo
    echo "======================================================"
    echo "Current SOCKS Proxy Settings:"
    echo "======================================================"
    networksetup -getsocksfirewallproxy "$PROXY_INTERFACE"
    echo

else
    echo "`basename $0` toggles SOCKS proxy settings on OS X"
    echo
    echo "Usage: "
    echo "  $ proxy on           # turns SOCKS proxy on"
    echo "  $ proxy off          # turns SOCKS proxy off"
    echo "  $ proxy status       # prints status of proxy settings"
    echo
    echo "proxy interface:      " $PROXY_INTERFACE
    echo "proxy host:           " $PROXY_HOST
    echo "proxy port:           " $PROXY_PORT
    echo
    exit 65 # end process with error to indicate incorrect arguments
fi