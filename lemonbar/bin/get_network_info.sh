#!/bin/sh


for DEV in `ip -o addr | awk '{if($3 != "lo" && $3 == "inet"){print $2}}' \
	| grep -v "docker"`
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
