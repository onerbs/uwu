module cli

import uwu.ups
import uwu

// TODO improve the argument parser.

// parse
[inline]
pub fn (mut self App) parse() ! {
	return self.parse_args(uwu.get_args())
}

// parse_args
[direct_array_access]
pub fn (mut self App) parse_args(args []string) ! {
	if args.len < self.need_args {
		return ups.not_enough('arguments', self.need_args, args.len)
	}

	if self.with_help {
		self.push_flag(mut flag_help)
	}
	if self.with_version {
		self.push_flag(mut flag_version)
	}

	for flag in self.flags {
		len := flag.armor().len
		if len > self.metro {
			self.metro = len
		}
	}

	mut i := 0
	for {
		if i >= args.len {
			break
		}
		it := args[i]
		match it {
			'-' {
				if self.with_stdin {
					self.input = uwu.get_text()
				} else {
					self.args << it
				}
				i--
			}
			'--' {
				self.args << args[i + 1..]
				break
			}
			else {
				if it.starts_with('--') {
					i = self.parse_long_flag(it[2..], args, i)!
				} else if it.starts_with('-') {
					for id in it[1..] {
						i = self.parse_short_flag(id, args, i)!
					}
				} else {
					self.args << it
				}
			}
		}
		i++
	}
}

fn (mut self App) parse_long_flag(name string, args []string, index int) !int {
	mut i := index
	if self.with_help && flag_help.name == name {
		return error(self.usage())
	}
	if self.with_version && flag_version.name == name {
		return error(self.version())
	}

	mut flag := self.find_flag_by_name(name)!

	if flag.kind != .bool {
		if i + 1 >= args.len {
			return ups.missing_value('flag', name)
		}
		i++
	}
	match flag.kind {
		.bool {
			flag.value = 'true'
			// continue
		}
		.int {
			value := args[i]
			if !is_numeric(value) {
				return ups.unexpected(value, 'an integer')
			}
		}
		// TODO .float {}
		.text {
			flag.value = args[i]
		}
	}
	return i
}

fn (mut self App) parse_short_flag(alias rune, args []string, index int) !int {
	mut i := index
	if self.with_help && flag_help.alias == alias {
		return error(self.usage())
	}
	if self.with_version && flag_version.alias == alias {
		return error(self.version())
	}

	mut flag := self.find_flag_by_alias(alias)!

	if flag.kind != .bool {
		if i + 1 >= args.len {
			return ups.missing_value('flag', '-${alias}')
		}
		i++
	}

	match flag.kind {
		.bool {
			flag.value = 'true'
			// continue
		}
		.int {
			value := args[i]
			if !is_numeric(value) {
				return ups.unexpected(value, 'an integer')
			}
		}
		// TODO .float {}
		.text {
			flag.value = args[i]
		}
	}
	return i
}

fn is_numeric(s string) bool {
	for c in s {
		if !c.is_digit() {
			return false
		}
	}
	return true
}
