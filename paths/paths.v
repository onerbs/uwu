module paths

import os

// from_here build a path from the current directory.
pub fn from_here(dirs ...string) string {
	return os.join_path(os.getwd(), ...dirs)
}

// from_home build a path from the user home directory.
pub fn from_home(dirs ...string) string {
	return os.join_path(os.home_dir(), ...dirs)
}

// simple return the basename of the file without extension.
pub fn simple(base string) string {
	return os.base(base).all_before('.')
}
