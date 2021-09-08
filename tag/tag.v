module tag

import term

pub fn good(base string) string {
	return tag(base, term.bright_bg_green, term.black, term.bold)
}

pub fn fail(base string) string {
	return tag(base, term.bright_bg_red, term.white, term.bold)
}

pub fn info(base string) string {
	return tag(base, term.bright_bg_yellow, term.black, term.bold)
}

pub fn warn(base string) string {
	return tag(base, term.bright_bg_magenta, term.black, term.bold)
}

fn tag(base string, cfns ...fn (string) string) string {
	if term.support_color {
		mut res := ' $base '
		for cfn in cfns {
			res = cfn(res)
		}
		return res
	}
	return base + ':'
}
