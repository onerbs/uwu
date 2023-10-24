module uwu

import uwu.str
import uwu.ups
import os

pub struct Command {
	base string
}

// new create a new Command instance.
pub fn Command.new(cmd string) Command {
	name := cmd.all_before(' ')
	path := get_exe_path(name) or { name }
	base := cmd.replace_once(name, str.safe_quote(path))
	return Command{base}
}

// need create a new Command instance.
// it will panic if the requested executable is not found.
pub fn Command.need(cmd string) Command {
	name := cmd.all_before(' ')
	path := need_exe_path(name) or { catch(err) }
	base := cmd.replace_once(name, str.safe_quote(path))
	return Command{base}
}

// sub create a new Command instance based on the current.
[inline]
pub fn (self Command) sub(cmd string) Command {
	base := '${self.base} ${cmd}'
	return Command{base}
}

// -----------------

// call will call the executable with the provided arguments,
// capture and return the output.
// this will return an error if the execution fails.
pub fn (self Command) call(args ...string) !string {
	cmd := self.make_cmd(...args)
	res := os.execute(cmd)
	out := res.output.trim_space()
	if res.exit_code != 0 {
		return error_with_code(out, res.exit_code)
	}
	return out
}

// make_cmd compose and returns the complete command as string.
fn (self Command) make_cmd(args ...string) string {
	mut all := []string{}
	all << self.base
	all << args.map(str.safe_quote(it))
	return all.join(' ')
}

// -----------------

// get_exe_path return the absolute path to the executable or the executable name.
fn get_exe_path(name string) !string {
	tmp := $if keep_exe_name ? { get_exe_name(name) } $else { name }
	return os.find_abs_path_of_executable(tmp)
}

// need_exe_path ensures the presence of the requested executable.
// return the absolute path to the executable or return an error.
fn need_exe_path(name string) !string {
	path := get_exe_path(name) or {
		return ups.not_found('executable', name)
	}
	return path
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
