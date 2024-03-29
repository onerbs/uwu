module paths

import os

// from_here build a path from the current directory.
@[inline]
pub fn from_here(dirs ...string) string {
	return os.join_path(os.getwd(), ...dirs)
}

// from_home build a path from the user home directory.
@[inline]
pub fn from_home(dirs ...string) string {
	return os.join_path(os.home_dir(), ...dirs)
}

// simple return the basename of the file without extension.
@[inline]
pub fn simple(base string) string {
	return os.base(base).all_before_last('.')
}

// chext change the filename extension.
@[inline]
pub fn chext(base string, next string) string {
	res := base.all_before_last('.')
	ext := next.trim(' .')
	if ext.len > 0 {
		return '${res}.${ext}'
	}
	return res
}
