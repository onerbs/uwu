module uwu

import os

// input read input from the user.
pub fn input(hint_ string) string {
	return os.input(highlight(hint))
}

fn highlight(hint string) string {
	return term.colorize(hint, term.bold) + ': '
}
