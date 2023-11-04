module uwu

import uwu.buffer

// read_bytes will read and return a buffer with all bytes in the source file.
pub fn (self File) read_bytes() []u8 {
	defer {
		self.rewind()
	}
	mut buf := []u8{}
	for byt in self {
		buf << byt
	}
	return buf
}

// read_text will read and return a string with the content of the source file.
[inline]
pub fn (self File) read_text() string {
	unsafe {
		dat := self.read_bytes()
		val := dat[0].vstring_with_len(dat.len)
		return val
	}
}

// read_lines read all lines from the source file.
pub fn (self File) read_lines() []string {
	defer {
		self.rewind()
	}
	mut buf := buffer.new()
	mut res := []string{}
	for byt in self {
		match byt {
			`\r` {}
			`\n` {
				res << buf.str()
			}
			else {
				buf << byt
			}
		}
	}
	res << buf.str()
	return res
}
