module paths

import os

// from_here build a path from the current directory.
[inline]
pub fn from_here(dirs ...string) string {
	return os.join_path(os.getwd(), ...dirs)
}

// from_home build a path from the user home directory.
[inline]
pub fn from_home(dirs ...string) string {
	return os.join_path(os.home_dir(), ...dirs)
}

// simple return the basename of the file without extension.
pub fn simple(base string) string {
	mut res := os.base(base)
	if res.contains('.') {
		res = res.all_before_last('.')
	}
	return res
}

// chext change the filename extension.
pub fn chext(base string, next string) string {
	mut res := base
	if res.contains('.') {
		res = res.all_before_last('.')
	}
	ext := next.trim('.')
	return if ext.len > 0 { '${res}.${ext}' } else { res }
}
