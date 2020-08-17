#!/bin/sh

bars='▁▁▂▃▄▅▆▇█#^'

drawBar() {
	case $1 in
		0)     color="\x0f" ;;
		[1-5]) color="\x0e" ;;
		*)     color="\x11" ;;
	esac
	echo "$color${bars:$1:1}\x0e"
}

cpuUsage="$(( $(( 100 - $(mpstat 1 1 | tail -n 1 | awk '{print int($NF)}') )) / 10 ))"
gpuUsage="$(( $(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits) / 10 ))"
ramStats="$(free | sed -n 2p)"
ramUsage="$(( $(( $(awk '{print $3}' <<< $ramStats) * 10 )) / $(awk '{print $2}' <<< $ramStats) ))"
echo -e "\x0e $(drawBar $cpuUsage)$(drawBar $gpuUsage)$(drawBar $ramUsage) 💻 \x0b"

