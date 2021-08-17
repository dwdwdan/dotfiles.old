# $TERM is linux when in a tty. I don't need neofetch there
if [[ "$TERM" != "linux" ]] then
	clear
	neofetch
fi

if [[ "$TTY" == "/dev/tty1" ]] then
	startx
fi
