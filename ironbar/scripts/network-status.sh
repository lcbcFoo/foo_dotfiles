#!/bin/sh

connection_type=$(
    LC_ALL=C nmcli -t -f TYPE,STATE device status 2>/dev/null |
        awk -F: '
            $1 == "ethernet" && $2 == "connected" { ethernet = 1 }
            $1 == "wifi" && $2 == "connected" { wifi = 1 }
            END {
                if (ethernet) print "ethernet"
                else if (wifi) print "wifi"
            }
        '
)

case "$connection_type" in
    ethernet)
        printf '󰈀 Ethernet\n'
        ;;
    wifi)
        printf '󰖩 Wi-Fi\n'
        ;;
    *)
        # Keep this foreground in sync with @coral in style.css.
        printf '<span foreground="#ff7f73">󰖪 Disconnected</span>\n'
        ;;
esac
