module uwu

const stdin = new_file(&C.FILE(voidptr(C.stdin)))

[inline]
pub fn get_bytes() []u8 {
	return uwu.stdin.read_bytes()
}

[inline]
pub fn get_text() string {
	return uwu.stdin.read_text()
}

[inline]
pub fn get_lines() []string {
	return uwu.stdin.read_lines()
}

[inline]
pub fn read_bytes(path string) ![]u8 {
	file := open(path)!
	defer {
		C.fclose(file.file)
	}
	return file.read_bytes()
}

[inline]
pub fn read_text(path string) !string {
	file := open(path)!
	defer {
		C.fclose(file.file)
	}
	return file.read_text()
}

[inline]
pub fn read_lines(path string) ![]string {
	file := open(path)!
	defer {
		C.fclose(file.file)
	}
	return file.read_lines()
}

// read_bytes will read and return a buffer with all bytes in the source file.
pub fn (self File) read_bytes() []u8 {
	mut buf := []u8{cap: 256}
	for byt in self {
		buf << byt
	}
	return buf
}

// read_text will read and return a string with the content of the source file.
[direct_array_access]
pub fn (self File) read_text() string {
	res := self.read_bytes()
	if res.len > 0 {
		return unsafe { res[0].vstring() }
	}
	return ''
}

// read_lines read all lines from the source file.
[direct_array_access]
pub fn (self File) read_lines() []string {
	mut buf := []u8{cap: 256}
	mut res := []string{}
	for byt in self {
		match byt {
			// `\r` {}
			`\n` {
				if buf.len > 0 {
					res << unsafe { buf[0].vstring() }
				} else {
					res << ''
				}
				buf.trim(0)
			}
			else {
				buf << byt
			}
		}
	}
	if buf.len > 0 {
		res << unsafe { buf[0].vstring() }
	} else {
		res << ''
	}
	return res
}
