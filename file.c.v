module uwu

import uwu.ups

[noinit]
pub struct File {
	ref  &C.FILE
	path string
}

pub fn open(path string, mode string) !File {
	if path.len < 1 {
		return ups.invalid('path', path)
	}
	mut ref := &C.FILE(unsafe { nil })
	$if windows {
		ref = C._wfopen(path.to_wide(), mode.to_wide())
	} $else {
		ref = C.fopen(&char(path.str), &char(mode.str))
	}
	if isnil(ref) {
		return ups.cannot('open file', path)
	}
	return File{ref, path}
}

pub fn (self File) reopen(mode string) !File {
	mut ref := &C.FILE(unsafe { nil })
	$if windows {
		ref = C._wfreopen(0, mode.to_wide(), self.ref)
	} $else {
		ref = C.freopen(0, &char(mode.str), self.ref)
	}
	if isnil(ref) {
		return ups.cannot('reopen file', self.path)
	}
	return File{
		...self
		ref: ref
	}
}

[inline]
pub fn (self File) rewind() {
	C.rewind(self.ref)
}

[inline]
pub fn (self File) close() {
	C.fclose(self.ref)
}

// next returns the next byte from the file content.
// this also allows File to be used as an iterator.
[inline]
pub fn (self File) next() ?u8 {
	byt := C.fgetc(self.ref)
	if byt < 0 {
		return none
	}
	return u8(byt)
}

fn C.fgetc(&C.FILE) int

pub const (
	stdin  = unsafe { File{&C.FILE(voidptr(C.stdin)), ''} }
	stdout = unsafe { File{&C.FILE(voidptr(C.stdout)), ''} }
	stderr = unsafe { File{&C.FILE(voidptr(C.stderr)), ''} }
)
