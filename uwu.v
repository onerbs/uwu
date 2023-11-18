module uwu

import uwu.str
import os

// get_args return the command-line arguments.
@[inline]
pub fn get_args() []string {
	return os.args[1..].clone()
}

// need_args ensures that the user have passed at least
// the number of command-line arguments to the program.
pub fn need_args(min int) ![]string {
	args := get_args()
	argc := args.filter(!it.starts_with('-')).len
	if argc < min {
		msg := 'not enough arguments. expecting ${min}, got ${argc}'
		return error_with_code(msg, 1)
	}
	return args
}

// exec execute a command and return it's output.
// this will throw an error if the return code is not zero.
@[inline]
pub fn exec(args ...string) !string {
	cmd := safe_cmd(...args)
	res := os.execute(cmd)
	out := res.output.trim_space()
	if res.exit_code != 0 {
		return error_with_code(out, res.exit_code)
	}
	return out
}

@[inline]
fn safe_cmd(args ...string) string {
	return args.map(str.safe_quote(it)).join(' ')
}
