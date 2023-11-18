module style

pub enum TextStyle {
	plain       = 0
	bold
	dim
	italic
	underline
	blink
	invert
	hidden
	strike
	black       = 30
	red
	green
	yellow
	blue
	purple
	cyan
	white
	over_black  = 40
	over_red
	over_green
	over_yellow
	over_blue
	over_purple
	over_cyan
	over_white
}

pub fn (ts TextStyle) style(s string) string {
	return ts.format(s)
}

@[inline]
fn (ts TextStyle) format(s string) string {
	a := int(ts)
	b := a / 10
	c := match b {
		0 {
			match a {
				0 { '0' }
				1 { '22' }
				else { '${20 + a}' }
			}
		}
		else {
			'${b * 10 + 9}'
		}
	}
	return '\x1b[${a}m${s}\x1b[${c}m'
}
