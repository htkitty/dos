if {$argc < 1 || $argc > 2} {
	puts "Invalid usage of argument"
	exit 1
}

set host [lindex $argv 0]
set ptl [lindex $argv 1]

set portsc [socket $host $ptl]

fconfigure $portsc -buffering line
if {$ptl == "80"} {
puts $portsc "GET / HTTP/1.1\nHost: $host\nConnection: close\n\n"

while {[gets $portsc resp] >= 0} {
       puts $resp
}
close $portsc
} else {
	puts "Non-supported protocol number;"
}
