module fs

// read_bytes will read and return a buffer with all bytes in the source file.
pub fn (f File) read_bytes() []u8 {
	defer {
		f.rewind()
	}
	mut buf := []u8{}
	for byt in f {
		buf << byt
	}
	return buf
}

// read_text will read and return a string with the content of the source file.
[inline]
pub fn (f File) read_text() string {
	return f.read_bytes().bytestr()
}

// read_lines read all lines from the source file.
pub fn (f File) read_lines() []string {
	defer {
		f.rewind()
	}
	mut buf := []u8{}
	mut res := []string{}
	for byt in f {
		match byt {
			`\r` {}
			`\n` {
				res << buf.bytestr()
				buf.trim(0)
			}
			else {
				buf << byt
			}
		}
	}
	res << buf.bytestr()
	return res
}

fn C.fgetc(&C.FILE) int

// next returns the next byte from the file content.
// this also allows File to be used as an iterator.
[inline]
pub fn (f File) next() ?u8 {
	byt := C.fgetc(f.ref)
	if byt < 0 {
		return none
	}
	return u8(byt)
}
