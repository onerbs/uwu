module uwu

import uwu.str
import os

pub struct Command {
	path string
}

// get_exe create a new Command instance.
pub fn get_exe(name string) Command {
	mut path := get_exe_path(name) or { name }
	path = str.safe_quote(path)
	return Command{path}
}

// need create a new Command instance.
// it will panic if the requested executable is not found.
pub fn need_exe(name string) Command {
	exe := get_exe(name)
	if exe.path == name {
		// terminate the program execution.
		die('the "${name}" executable is not available')
	}
	return exe
}

// exec will call the executable with the provided arguments,
// capture and return the output.
// this will return an error if the execution fails.
[inline]
pub fn (exe Command) exec(args ...string) !string {
	mut cmd := [exe.path]
	cmd << args
	return exec(...cmd)
}

// get_exe_path return the absolute path to the executable or the executable name.
fn get_exe_path(name string) !string {
	tmp := $if keep_exe_name ? { get_exe_name(name) } $else { name }
	return os.find_abs_path_of_executable(tmp)
}

fn get_exe_name(name string) string {
	$if windows {
		if !name.ends_with('.exe') {
			return '${name}.exe'
		}
	} $else {
		if name.ends_with('.exe') {
			return name.all_before_last('.')
		}
	}
	return name
}
