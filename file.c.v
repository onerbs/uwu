module uwu

import uwu.ups

fn C.fgetc(&C.FILE) int

pub const (
	stdin  = unsafe { wrap_file(&C.FILE(voidptr(C.stdin))) }
	stdout = unsafe { wrap_file(&C.FILE(voidptr(C.stdout))) }
	stderr = unsafe { wrap_file(&C.FILE(voidptr(C.stderr))) }
)

[noinit]
pub struct File {
	file &C.FILE
}

[inline]
fn wrap_file(file &C.FILE) File {
	return unsafe { File{file} }
}

pub fn open(path string, mode string) !File {
	if path.len < 1 {
		return ups.invalid('path', path)
	}
	file := open_helper(path, mode)!
	return wrap_file(file)
}

fn open_helper(path string, mode string) !&C.FILE {
	mut file := &C.FILE(unsafe { nil })
	$if windows {
		file = C._wfopen(path.to_wide(), mode.to_wide())
	} $else {
		file = C.fopen(&char(path.str), &char(mode.str))
	}
	if isnil(file) {
		return ups.cannot('open file', path)
	}
	return file
}

[inline]
pub fn (self File) rewind() {
	C.rewind(self.file)
}

[inline]
pub fn (self File) close() bool {
	return C.fclose(self.file) == 0
}

// next returns the next byte from the file content.
// this also allows File to be used as an iterator.
[inline]
pub fn (self File) next() ?u8 {
	byt := C.fgetc(self.file)
	if byt < 0 {
		return none
	}
	return u8(byt)
}
