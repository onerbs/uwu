module uwu

import uwu.ups
import os

// get_args return the command-line arguments.
[inline]
pub fn get_args() []string {
	return os.args[1..].clone()
}

// need_args ensures that the user have passed at least
// the number of command-line arguments to the program.
pub fn need_args(min int) ![]string {
	args := get_args()
	argc := args.find(!it.starts_with('-')).len
	if argc < min {
		return ups.not_enough('arguments', min, argc)
	}
	return args
}

// system execute a command and return the status code.
[inline]
pub fn system(cmd string) int {
	$if windows {
		return os.system('${cmd} >NUL 2>NUL')
	} $else {
		return os.system('${cmd} >/dev/null 2>&1')
	}
}
