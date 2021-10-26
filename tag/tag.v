module tag

import uwu.scene

pub enum Color {
	blue
	green
	orange
	purple
	red
	yellow
	black
	gray
	white
}

// tag create a tag of the specified color.
pub fn tag(base string, c Color) string {
	fore, back := colors(c)
	fr, fg, fb := rgb(fore)
	br, bg, bb := rgb(back)
	return '\x1b[38;2;$fr;$fg;$fb;48;2;$br;$bg;$bb;1m $base \x1b[m'
}

// out create a tag of the specified color only if the standard output supports color.
pub fn out(base string, c Color) string {
	if scene.can_show_color_on_stdout {
		return tag(base, c)
	}
	return base + ':'
}

// err create a tag of the specified color only if the standard error supports color.
pub fn err(base string, c Color) string {
	if scene.can_show_color_on_stderr {
		return tag(base, c)
	}
	return base + ':'
}

// put print the specified tagged message to the standard output.
pub fn put(base string, c Color, msg string) {
	println(out(base, c) + ' ' + msg)
}

// eput print the specified tagged message to the standard error.
pub fn eput(base string, c Color, msg string) {
	eprintln(err(base, c) + ' ' + msg)
}

fn rgb(hex int) (int, int, int) {
	return hex >> 16, hex >> 8 & 0xFF, hex & 0xFF
}

// fore, back
fn colors(c Color) (int, int) {
	return match c {
		.blue { 0, 0x45aaf2 }
		.green { 0, 0x26de81 }
		.orange { 0, 0xfd9644 }
		.purple { 0xffffff, 0xa55eea }
		.red { 0xffffff, 0xfc5c65 }
		.yellow { 0, 0xfed330 }
		.black { 0xffffff, 0 }
		.gray { 0xffffff, 0x757575 }
		.white { 0, 0xffffff }
	}
}
