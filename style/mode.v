module style

/// text modes

[inline]
pub fn plain(s string) string {
	return format(s, 0, 0)
}

[inline]
pub fn bold(s string) string {
	return format(s, 1, 22)
}

[inline]
pub fn dim(s string) string {
	return format(s, 2, 22)
}

[inline]
pub fn italic(s string) string {
	return format(s, 3, 23)
}

[inline]
pub fn underline(s string) string {
	return format(s, 4, 24)
}

[inline]
pub fn blink(s string) string {
	return format(s, 5, 25)
}

[inline]
pub fn rapid_blink(s string) string {
	return format(s, 6, 25)
}

[inline]
pub fn invert(s string) string {
	return format(s, 7, 27)
}

[inline]
pub fn hide(s string) string {
	return format(s, 8, 28)
}

[inline]
pub fn strike(s string) string {
	return format(s, 9, 29)
}
