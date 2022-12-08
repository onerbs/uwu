module uwu

import uwu.ups
import os

// get_args return the command-line arguments.
[inline]
pub fn get_args() []string {
	return os.args[1..]
}

// need_args ensures that the user have passed at least
// the number of command-line arguments to the program.
pub fn need_args(min int) ![]string {
	args := get_args()
	if args.len < min {
		return ups.not_enough('arguments', min, args.len)
	}
	return args
}

// need_exe ensures the presence of the requested executable.
// return the absolute path to the executable or terminate the program execution.
pub fn need_exe(name string) string {
	mut exe := name
	$if !keep_exe_name ? {
		exe = get_exe_name(name)
	}
	return os.find_abs_path_of_executable(exe) or { catch(ups.not_found('executable', exe)) }
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

// catch will print a fancy error message and exit with the error code.
[noreturn]
pub fn catch(err IError) {
	code := err.code()
	msg := err.msg()
	if msg.len > 0 {
		match code {
			0 {
				eprintln(msg)
			}
			else {
				eprintln('\e[1;30;41m Error \e[0m ${msg}')
			}
		}
	}
	exit(code)
}
