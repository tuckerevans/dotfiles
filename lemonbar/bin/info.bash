#!/bin/bash

est_date() {
	TIME=`date '+%Y-%m-%d %H:%M:%S'`
	echo "EST: $TIME"
}

utc_date() {
	TIME=`date --utc '+%H:%M'`
	echo "UTC: $TIME"
}

battery() {
	BAT_FULL=`cat /sys/class/power_supply/BAT0/charge_full`
	BAT_NOW=`cat /sys/class/power_supply/BAT0/charge_now`
	BAT_STATUS=`cat /sys/class/power_supply/BAT0/status`
	echo -n "BAT: "

	test "$BAT_STATUS" = "Charging" && echo -n "+" || echo -n "-"

	PERCENT=`expr \( "$BAT_NOW" \* 100 \) / "$BAT_FULL"`
	PERCENT_HUNDRETHS=`expr \( \( "$BAT_NOW" \* 10000 \) / "$BAT_FULL" \)\
		- \( "$PERCENT" \* 100 \)`
	echo "$PERCENT.$PERCENT_HUNDRETHS%"
}

sound_level() {
	echo -n "VOL: "
	amixer get Master | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p' | uniq
}

cpu_levels() {
	PERCENT_HUNDRETHS=`ps -eo pcpu | awk 'BEGIN {sum=0.0f} {sum+=$1} END {print sum * 100}'`
	PERCENT=`expr "$PERCENT_HUNDRETHS" / 100`
	PERCENT_HUNDRETHS=`expr "$PERCENT_HUNDRETHS" - \( "$PERCENT" \* 100 \)`
	echo "CPU: $PERCENT.$PERCENT_HUNDRETHS"
}

ram_usage() {
	FREE_MEM=`grep -E 'MemFree' /proc/meminfo | awk '{print $2}'`
	TOTAL_MEM=`grep -E 'MemTotal' /proc/meminfo | awk '{print $2}'`
	OTHER_MEM=`grep -E '^(Buffers|Cached)' /proc/meminfo | awk \
		'BEGIN {sum = 0} {sum+=$2} END {print sum}'`
	echo "RAM: " \
		`expr \( "$TOTAL_MEM" - "$FREE_MEM" - "$OTHER_MEM" \) / 1024`\
		"MiB"
}

network() {
	for DEV in `ip -o addr | awk '{if($2 != "lo" && $3 == "inet"){print $2}}'`
	do
		SSID=""
		OUTPUT=""
		ADDR=`ip addr show dev "$DEV" | grep -E "inet[^6]" \
		| awk '{print $2}'`
		MATCH=`expr "$DEV" : "^wlp"`
		if test "$MATCH" -gt 0
		then
			SSID=`iw dev "$DEV" link | grep SSID | awk '{print $2}'`
			SSID="$SSID: "
		fi

		if test -n "$OUTPUT"
		then
			OUTPUT="$OUTPUT | ($DEV) $SSID$ADDR"
		else
			OUTPUT="($DEV) $SSID$ADDR"
		fi
	done

	echo "$OUTPUT"
}

desktops() {
	OUTPUT=""
	FOCUSED=`bspc query -D -d focused --names`
	for DESKTOP in `bspc query -D --names`
	do
		if test -n "$OUTPUT"
		then
			OUTPUT="$OUTPUT | "
		fi

		if test "$FOCUSED" = "$DESKTOP"
		then
			OUTPUT="$OUTPUT%{R}$DESKTOP%{R}"
		else
			OUTPUT="$OUTPUT$DESKTOP"
		fi
	done

	echo "$OUTPUT"
}


test_all() {
	echo -ne  "est_date:\n\t"
	est_date
	echo -ne  "utc_date:\n\t"
	utc_date
	echo -ne "battery\n\t"
	battery
	echo -ne "sound\n\t"
	sound_level
	echo -ne "cpu\n\t"
	cpu_levels
	echo -ne "ram\n\t"
	ram_usage
	echo -ne "network\n\t"
	network
	echo -ne "desktops"
	desktops
}

if `test "$1" = "test"`
then
	test_all
	PIPE=`bspc subscribe desktop -f`
	echo "$PIPE"
else
	while echo
	do
		DESK=`desktops`
		NETWORK=`network`
		SOUND=`sound_level`
		BAT=`battery`
		CPU=`cpu_levels`
		RAM=`ram_usage`
		EST=`est_date`
		UTC=`utc_date`

		echo -n "%{l}$DESK%{r}$NETWORK | $SOUND |"\
			"$BAT | $CPU | $RAM | $EST | $UTC"
		sleep 5
	done
fi
