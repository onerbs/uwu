module style

type StyleFn = fn (string) string

[inline]
pub fn tag(text string, style ...StyleFn) string {
	return tint(' ${text} ', ...style)
}

[inline]
pub fn tint(text string, style ...StyleFn) string {
	mut res := text
	for apply in style {
		res = apply(res)
	}
	return res
}

[inline]
fn format(s string, a int, b int) string {
	return '\x1b[${a}m${s}\x1b[${b}m'
}
