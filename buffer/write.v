module buffer

// write appends a string to the accumulated buffer.
@[inline]
pub fn (mut self Buffer) write(s string) {
	unsafe { self.push_many(s.str, s.len) }
}

// writeln appends a string and a newline character to the accumulated buffer.
@[inline]
pub fn (mut self Buffer) writeln(s string) {
	self.write(s)
	self << `\n`
}
