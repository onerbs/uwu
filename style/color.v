module style

/// foreground color

[inline]
pub fn black(s string) string {
	return format(s, 30, 39)
}

[inline]
pub fn red(s string) string {
	return format(s, 31, 39)
}

[inline]
pub fn green(s string) string {
	return format(s, 32, 39)
}

[inline]
pub fn yellow(s string) string {
	return format(s, 33, 39)
}

[inline]
pub fn blue(s string) string {
	return format(s, 34, 39)
}

[inline]
pub fn purple(s string) string {
	return format(s, 35, 39)
}

[inline]
pub fn cyan(s string) string {
	return format(s, 36, 39)
}

[inline]
pub fn white(s string) string {
	return format(s, 37, 39)
}

/// background color

[inline]
pub fn over_black(s string) string {
	return format(s, 40, 49)
}

[inline]
pub fn over_red(s string) string {
	return format(s, 41, 49)
}

[inline]
pub fn over_green(s string) string {
	return format(s, 42, 49)
}

[inline]
pub fn over_yellow(s string) string {
	return format(s, 43, 49)
}

[inline]
pub fn over_blue(s string) string {
	return format(s, 44, 49)
}

[inline]
pub fn over_purple(s string) string {
	return format(s, 45, 49)
}

[inline]
pub fn over_cyan(s string) string {
	return format(s, 46, 49)
}

[inline]
pub fn over_white(s string) string {
	return format(s, 47, 49)
}
