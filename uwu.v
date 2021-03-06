module uwu

import uwu.ups
import uwu.tag
import uwu.buffer
import os

// get_args return the command-line arguments.
pub fn get_args() []string {
	return os.args[1..]
}

// need_args ensures that the user have passed at least
// the number of command-line arguments to the program.
pub fn need_args(min int) ?[]string {
	args := get_args()
	if args.len < min {
		ups.not_enough('arguments', min, args.len) ?
	}
	return args
}

// need_env ensures that the specified environment variable has a value.
pub fn need_env(name string) ?string {
	res := os.getenv(name)
	if res == '' {
		ups.missing_value('environment variable', name) ?
	}
	return res
}

// need_exe ensures the presence of the requested executable.
// return the absolute path to the executable or terminate the program execution.
pub fn need_exe(name string) string {
	mut exe := name
	$if !keep_exe_name ? {
		exe = get_exe_name(name)
	}
	return os.find_abs_path_of_executable(exe) or {
		catch(ups.item_not_found_error('executable', exe))
	}
}

fn get_exe_name(base string) string {
	$if windows {
		if !base.ends_with('.exe') {
			return base + '.exe'
		}
	} $else {
		if base.ends_with('.exe') {
			return os.base(base)
		}
	}
	return base
}

// alert will print the error message.
[if debug]
pub fn alert(err IError) {
	report(tag.err('Alert', .orange), err)
}

// catch will print the error message and exit with the error code.
[noreturn]
pub fn catch(err IError) {
	report(tag.err('Error', .red), err)
	exit(err.code)
}

// die will print an error message and exit with code `2`.
[noreturn]
pub fn die(msg string) {
	catch(error_with_code(msg, 2))
}

fn report(tag string, err IError) {
	mut buf := buffer.cap(0x100)
	if err.code != 0 {
		buf.write(tag)
		buf << ` `
	}
	buf.write(err.msg)
	if buf.last() != `.` {
		buf << `.`
	}
	eprintln(buf.str())
}
