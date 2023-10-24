module style

[inline]
pub fn text(s string) {
	t := tag(@FN, bold, black, over_blue)
	eprintln('${t} ${s}.')
}

[inline]
pub fn done(s string) {
	t := tag(@FN, bold, black, over_green)
	eprintln('${t} ${s}.')
}

[inline]
pub fn info(s string) {
	t := tag(@FN, bold, black, over_yellow)
	eprintln('${t} ${s}.')
}

[inline]
pub fn warn(s string) {
	t := tag(@FN, bold, black, over_purple)
	eprintln('${t} ${s}.')
}

[inline]
pub fn fail(s string) {
	t := tag(@FN, bold, black, over_red)
	eprintln('${t} ${s}.')
}
