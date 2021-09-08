module uwu

import uwu.ups
import uwu.tag

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

// catch will print the error message and exit with the error code.
[noreturn]
pub fn catch(err IError) {
	if err.code != 0 {
		eprint(tag.fail('Error') + ' ')
	}
	eprintln(err.msg)
	exit(err.code)
}

// die will print an error message and exit with code `2`.
[noreturn]
pub fn die(msg string) {
	catch(error_with_code(msg, 2))
}
