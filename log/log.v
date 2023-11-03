module log

import uwu.style { tag }

[inline]
pub fn text(s string) {
	t := tag(@FN, .bold, .blue)
	eprintln('${t} ${s}')
}

[inline]
pub fn done(s string) {
	t := tag(@FN, .bold, .green)
	eprintln('${t} ${s}')
}

[inline]
pub fn info(s string) {
	t := tag(@FN, .bold, .yellow)
	eprintln('${t} ${s}')
}

[inline]
pub fn warn(s string) {
	t := tag(@FN, .bold, .purple)
	eprintln('${t} ${s}')
}

[inline]
pub fn fail(s string) {
	t := tag(@FN, .bold, .red)
	eprintln('${t} ${s}')
}
