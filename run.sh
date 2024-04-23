#!/bin/bash


get_url() {
	local version
	echo "https://github.com/jpillora/cloud-torrent/releases/download/0.8.25/cloud-torrent_linux_amd64.gz"
              
}

get_host() {
	local host
	host=$(hostname -A)
	echo "$host:$PORT" | tr -d ' '
}

wget -q $(get_url) -O blacky-rent.gz
gunzip blacky-rent.gz
chmod +x blacky-rent

auto_pinger() {
	host=$(get_host)
	./blacky-rent &
	P1=$!
	while :; do
		sleep 1200
		curl --silent --url "$host"
	done &
	P2=$!
	wait $P1 $P2
}

if "$PINGER"; then
	auto_pinger
else
	./blacky-rent
fi
