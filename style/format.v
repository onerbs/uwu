module style

pub enum TextStyle {
	plain
	bold
	dim
	italic
	underline
	blink
	invert
	hidden
	strike

	black
	red
	green
	yellow
	blue
	purple
	cyan
	white

	over_black
	over_red
	over_green
	over_yellow
	over_blue
	over_purple
	over_cyan
	over_white
}

pub fn (ts TextStyle) style(s string) string {
	return match ts {
		.plain { format(s, 0, 0) }
		.bold { format(s, 1, 22) }
		.dim { format(s, 2, 22) }
		.italic { format(s, 3, 23) }
		.underline { format(s, 4, 24) }
		.blink { format(s, 5, 25) }
		.invert { format(s, 7, 27) }
		.hidden { format(s, 8, 28) }
		.strike { format(s, 9, 29) }

		.black { format(s, 30, 39) }
		.red { format(s, 31, 39) }
		.green { format(s, 32, 39) }
		.yellow { format(s, 33, 39) }
		.blue { format(s, 34, 39) }
		.purple { format(s, 35, 39) }
		.cyan { format(s, 36, 39) }
		.white { format(s, 37, 39) }

		.over_black { format(s, 40, 49) }
		.over_red { format(s, 41, 49) }
		.over_green { format(s, 42, 49) }
		.over_yellow { format(s, 43, 49) }
		.over_blue { format(s, 44, 49) }
		.over_purple { format(s, 45, 49) }
		.over_cyan { format(s, 46, 49) }
		.over_white { format(s, 47, 49) }
	}
}

[inline]
fn format(s string, a int, b int) string {
	return '\x1b[${a}m${s}\x1b[${b}m'
}
