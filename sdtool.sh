#config flags
url="http://localhost:8080"
tor=1

#torconf
if [[ tor == 1 ]] then
	opt="torify"; tor &
fi

#logic
if !command -v wget > /dev/null; then
	printf "cannot find wget, trying curl\n"
	while true; do
		$opt curl -I "$url"
	done
fi
if command -v wget > /dev/null; then
	while true; do
		$opt wget "$url"
	done
fi
