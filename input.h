#ifndef INPUT_H
#define INPUT_H

#include <termios.h>

struct termios normal;

void enable_raw_mode() {
	struct termios raw = normal;
	tcgetattr(0, &normal);
	raw.c_iflag &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);
	raw.c_oflag &= ~(OPOST);
	raw.c_cflag |= (CS8);
	raw.c_lflag &= ~(ECHO | ICANON | IEXTEN | ISIG);
	raw.c_cc[VMIN] = 0;
	raw.c_cc[VTIME] = 4;
	tcsetattr(0, TCSAFLUSH, &raw);
}

void disable_raw_mode() {
	tcsetattr(0, TCSAFLUSH, &normal);
}

#endif
