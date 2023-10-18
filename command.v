module uwu

import uwu.str
import uwu.ups
import os

[noinit]
pub struct Command {
	base string
}

// new_command create a new Command instance.
pub fn new_command(cmd string) Command {
	name := cmd.all_before(' ')
	path := get_exe_path(name)
	base := cmd.replace_once(name, str.safe_quote(path))
	return Command{base}
}

// need_command create a new Command instance.
// it will panic if the requested executable is not found.
pub fn need_command(cmd string) Command {
	name := cmd.all_before(' ')
	path := need_exe_path(name) or { catch(err) }
	base := cmd.replace_once(name, str.safe_quote(path))
	return Command{base}
}

// sub create a new Command instance based on the current.
pub fn (self Command) sub(cmd string) Command {
	base := '${self.base} ${cmd}'
	return Command{base}
}

// -----------------

// run will call the executable with the provided arguments,
// capture and return the output.
// this will return an error if the execution fails.
pub fn (self Command) run(args ...string) !string {
	cmd := self.get_cmd(...args)
	$if vv ? {
		eprintln(@FN + ': ' + cmd)
	}
	res := os.execute(cmd)
	out := res.output.trim_space()
	if res.exit_code != 0 {
		return error_with_code(out, res.exit_code)
	}
	return out
}

// get will call the executable with the provided arguments,
// capture and return the output.
// this will return an empty string if the execution fails.
[inline]
pub fn (self Command) get(cmd ...string) string {
	return self.run(...cmd) or { '' }
}

// get_cmd compose and returns the complete command as string.
pub fn (self Command) get_cmd(args ...string) string {
	mut all := []string{}
	all << self.base
	all << args
	return make_cmd(all)
}

[inline]
fn make_cmd(args []string) string {
	mut res := args.map(str.safe_quote(it))
	res[0] = args[0]
	return res.join(' ')
}

// -----------------

// get_exe_path return the absolute path to the executable or the executable name.
fn get_exe_path(name string) string {
	tmp := $if keep_exe_name ? { get_exe_name(name) } $else { name }
	return os.find_abs_path_of_executable(tmp) or { tmp }
}

// need_exe_path ensures the presence of the requested executable.
// return the absolute path to the executable or return an error.
fn need_exe_path(name string) !string {
	path := get_exe_path(name)
	if path == name {
		return ups.not_found('executable', name)
	}
	return path
}

fn get_exe_name(name string) string {
	$if windows {
		if !name.ends_with('.exe') {
			return name + '.exe'
		}
	} $else {
		if name.ends_with('.exe') {
			return name.all_before_last('.')
		}
	}
	return name
}
