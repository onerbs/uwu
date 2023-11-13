module fs

import uwu.ups
import os

[noinit]
pub struct File {
	ref  &C.FILE
	path string
}

// open will open the specified file in the selected mode.
pub fn open(name string, mode string) !File {
	if name.len < 1 {
		return ups.invalid('file', name)
	}
	path := os.real_path(name)
	mut ref := $if windows {
		C._wfopen(path.to_wide(), mode.to_wide())
	} $else {
		C.fopen(&char(path.str), &char(mode.str))
	}
	if isnil(ref) {
		return ups.cannot('open the file', name)
	}
	return File{ref, path}
}

pub fn (f File) reopen(mode string) !File {
	ref := $if windows {
		C._wfreopen(0, mode.to_wide(), f.ref)
	} $else {
		C.freopen(0, &char(mode.str), f.ref)
	}
	if isnil(ref) {
		name := os.base(f.path)
		return ups.cannot('reopen the file', name)
	}
	return File{
		...f
		ref: ref
	}
}

[inline]
pub fn (f File) rewind() {
	C.rewind(f.ref)
}

[inline]
pub fn (f File) close() {
	C.fclose(f.ref)
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
