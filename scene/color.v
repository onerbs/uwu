module scene

import os

// can_show_color_on_stdout is true if colors are allowed in stdout.
pub const can_show_color_on_stdout = supports_escape_sequences(1)

// can_show_color_on_stderr is true if colors are allowed in stderr.
pub const can_show_color_on_stderr = supports_escape_sequences(2)

// can_show_color is true if colors are allowed in both stdout and stderr.
pub const can_show_color = can_show_color_on_stdout && can_show_color_on_stderr

// colorize_out returns the message `s` colored by the specified color functions,
// only if colored output is allowed in stdout.
// Example: scene.colorize_out('the message', term.bold, term.green)
pub fn colorize_out(s string, cfns ...ColorFn) string {
	if scene.can_show_color_on_stdout {
		return colorize(s, ...cfns)
	}
	return s
}

// colorize_err returns the message `s` colored by the specified color functions,
// only if colored output is allowed in stderr.
// Example: scene.colorize_err('the message', term.bold, term.red)
pub fn colorize_err(s string, cfns ...ColorFn) string {
	if scene.can_show_color_on_stderr {
		return colorize(s, ...cfns)
	}
	return s
}

// colorize returns the message `s` colored by the specified color functions.
// Example: scene.colorize('the message', term.bold, term.yellow)
pub fn colorize(s string, cfns ...ColorFn) string {
	mut res := s
	for cfn in cfns {
		res = cfn(res)
	}
	return res
}

type ColorFn = fn (string) string

// @see term.supports_escape_sequences
// add support for NO_COLOR environment variable.
fn supports_escape_sequences(fd int) bool {
	if os.is_atty(1) <= 0 || os.getenv('TERM') == 'dumb' {
		return false
	}
	match os.getenv('VCOLORS') {
		'always' { return true }
		'never' { return false }
		else {}
	}
	match os.getenv('NO_COLOR') {
		'' {}
		else { return false }
	}
	$if windows {
		if os.getenv('ConEmuANSI') == 'ON' {
			return true
		}
		// 4 is enable_virtual_terminal_processing
		return os.is_atty(fd) & 0x0004 > 0
	} $else {
		return os.is_atty(fd) > 0
	}
}
