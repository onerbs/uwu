module uwu

// write_bytes will read and return a buffer with all bytes in the source file.
[inline]
pub fn (self File) write_bytes(dat []u8) {
	C.fprintf(self.ref, &char(dat.data))
}

// write_text will read and return a string with the content of the source file.
[inline]
pub fn (self File) write_text(msg string) {
	self.write_bytes(msg.bytes())
}

// write_lines read all lines from the source file.
[inline]
pub fn (self File) write_lines(lines ...string) {
	self.write_text(lines.join('\n'))
}
