module uwu

import uwu.ups

// write_bytes will read and return a buffer with all bytes in the source file.
[inline]
pub fn (f File) write_bytes(dat []u8) !int {
	size := int(C.fwrite(dat.data, 1, dat.len, f.ref))
	if size < dat.len {
		return error_with_code('failed to write ${dat.len} bytes, wrote ${size}', 1)
	}
	return size
}

// write_text will read and return a string with the content of the source file.
[inline]
pub fn (f File) write_text(msg string) ! {
	if C.fputs(msg.str, f.ref) == 0 {
		return ups.cannot('write_text to file', f.path)
	}
}

// write_lines read all lines from the source file.
[inline]
pub fn (f File) write_lines(lines ...string) ! {
	return f.write_text(lines.join_lines())
}
