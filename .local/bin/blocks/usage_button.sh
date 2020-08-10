#!/bin/sh

sendCPUUsageNotification() {
	dunstify -i "computer" -r "142859" -a "removeFromHistory" -t 0 "Querying System Resource Usage..." "Please be patient :)"
	cpuUsage="$((100 - $(mpstat 1 3 | tail -n 1 | awk '{print int($NF)}')))"
	gpuUsage="$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)"

	ramUsage="$(free -h | sed -n 2p | awk '{print $3}')"
	vramUsage="$(nvidia-smi --query-gpu=memory.used --format=csv,noheader)"

	cpuTemp="$(sensors -u | awk '/Package id 0:/{getline; print int($2)}')"
	gpuTemp="$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)"

	message="CPU Usage: $cpuUsage% ($cpuTemp°C)\nGPU Usage: $gpuUsage% ($gpuTemp°C)\nRAM Usage: $ramUsage\nVRAM Usage: $vramUsage\n"
	dunstify -i "computer" -r "142859" -t 0 "System Resources Status" "$message"
}

case "$1" in
	1) st -t "vtop system monitor" -c "centered-term" -g "150x50" -e vtop ;;
	2) sendCPUUsageNotification ;;
	3) st -t "mpstat cpu monitor" -c "centered-term" -g "150x50" -e mpstat 1 ;;
esac
