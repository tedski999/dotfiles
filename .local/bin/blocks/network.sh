#!/bin/sh


color="\x11"
message="🌐"
for devStatus in $(nmcli -t -f STATE,TYPE dev status); do
	if [[ "$(awk -F':' '{print $1}' <<< $devStatus)" == "connected" ]]; then
		devType="$(awk -F':' '{print $2}' <<< $devStatus)"
		case $devType in
			"wifi") message="📶" ;;
			"ethernet") message="🖧" ;;
		esac
		wget -q --spider http://google.com
		if [[ $? -eq 0 ]]; then
			color="\x10"
		fi
	fi
done

echo -e "$color $message \x0b"
