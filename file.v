module uwu

[inline]
pub fn get_bytes() []u8 {
	return stdin.read_bytes()
}

[inline]
pub fn get_text() string {
	return stdin.read_text()
}

[inline]
pub fn get_lines() []string {
	return stdin.read_lines()
}
