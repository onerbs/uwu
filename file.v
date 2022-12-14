module uwu

import uwu.ups
import os

[noinit]
struct File {
	file &C.FILE
}

[inline]
fn new_file(file &C.FILE) File {
	return unsafe { File{file} }
}

// open will open the file at `path` in read-only mode.
[inline]
fn open(path string) !File {
	return open_file(path, .read)
}

[inline]
fn open_file(path string, mode FileMode) !File {
	if path.len < 1 {
		return ups.invalid('path', path)
	}
	mut file := os.vfopen(path, mode.str())!
	return new_file(file)
}

// next returns the next byte from the file content.
// this also allows File to be used as an iterator.
fn (self File) next() ?u8 {
	byt := C.fgetc(self.file)
	if byt < 0 {
		return none
	}
	return u8(byt)
}
