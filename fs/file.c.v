module fs

import os

@[noinit]
pub struct File {
	ref  &C.FILE
	path string
}

pub const (
	stdin = unsafe { File{ref: &C.FILE(voidptr(C.stdin))} }
)

// open will open the specified file in the selected mode.
pub fn open(name string, mode string) !File {
	if name.len < 1 {
		return error('empty file path')
	}
	path := os.real_path(name)
	mut ref := $if windows {
		C._wfopen(path.to_wide(), mode.to_wide())
	} $else {
		C.fopen(&char(path.str), &char(mode.str))
	}
	if isnil(ref) {
		return error('could not open the file ${name}')
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
		return error('could not reopen the file ${name}')
	}
	return File{
		...f
		ref: ref
	}
}

@[inline]
pub fn (f File) rewind() {
	C.rewind(f.ref)
}

@[inline]
pub fn (f File) close() {
	C.fclose(f.ref)
}
