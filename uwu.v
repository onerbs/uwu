module uwu

import uwu.ups
import uwu.str
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
	argc := args.filter(!it.starts_with('-')).len
	if argc < min {
		return ups.not_enough('arguments', min, argc)
	}
	return args
}

// exec execute a command and return it's output.
// this will throw an error if the return code is not zero.
[inline]
pub fn exec(args ...string) !string {
	cmd := safe_cmd(...args)
	res := os.execute(cmd)
	out := res.output.trim_space()
	if res.exit_code != 0 {
		return error_with_code(out, res.exit_code)
	}
	return out
}

// call execute a command and return the status code.
[inline]
pub fn call(args ...string) int {
	mut cmd := safe_cmd(...args)
	cmd += $if windows {
		' >nul 2>nul'
	} $else {
		' >/dev/null 2>&1'
	}
	return os.system(cmd)
}

[inline]
fn safe_cmd(args ...string) string {
	return args.map(str.safe_quote(it)).join(' ')
}
