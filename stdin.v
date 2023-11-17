module uwu

import fs

[inline]
pub fn get_bytes() []u8 {
	return fs.stdin.read_bytes()
}

[inline]
pub fn get_text() string {
	return fs.stdin.read_text()
}

[inline]
pub fn get_lines() []string {
	return fs.stdin.read_lines()
}
