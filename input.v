module uwu

import uwu.scene
import term
import os

// input read input from the user.
pub fn input(hint string) string {
	return os.input(highlight(hint))
}

fn highlight(hint string) string {
	return scene.colorize_out(hint, term.bold) + ': '
}
