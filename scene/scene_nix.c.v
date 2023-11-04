module scene

#include <termios.h>

struct C.termios {
mut:
	c_iflag int
	c_oflag int
	c_cflag int
	c_lflag int
	c_cc    [10]int
}

fn C.tcgetattr(fd int, ptr &C.termios) int

fn C.tcsetattr(fd int, action int, ptr &C.termios)

const ts_normal = C.termios{}

fn init() {
	C.tcgetattr(0, &scene.ts_normal)
}

pub fn raw_mode() {
	mut raw := scene.ts_normal
	raw.c_iflag &= ~(C.BRKINT | C.ICRNL | C.INPCK | C.ISTRIP | C.IXON)
	raw.c_oflag &= ~C.OPOST
	raw.c_cflag |= C.CS8
	raw.c_lflag &= ~(C.ECHO | C.ICANON | C.IEXTEN | C.ISIG)
	raw.c_cc[C.VMIN] = 0
	raw.c_cc[C.VTIME] = 4
	C.tcsetattr(0, C.TCSAFLUSH, &raw)
}

pub fn normal_mode() {
	C.tcsetattr(0, C.TCSAFLUSH, &scene.ts_normal)
}
