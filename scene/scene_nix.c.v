module scene

#include <termios.h>

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
