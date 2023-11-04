module uwu

// write_bytes will read and return a buffer with all bytes in the source file.
[inline]
pub fn (f File) write_bytes(dat []u8) {
	C.fwrite(dat.data, 1, dat.len, f.ref)
}

// write_text will read and return a string with the content of the source file.
[inline]
pub fn (f File) write_text(msg string) {
	C.fputs(msg.str, f.ref)
}

// write_lines read all lines from the source file.
[inline]
pub fn (f File) write_lines(lines ...string) {
	f.write_text(lines.join('\n'))
}
