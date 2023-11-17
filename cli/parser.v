module cli

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
		return error('not enough arguments. expecting ${self.need_args}, got ${args.len}')
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
				if args.len - 1 == i && self.with_stdin {
					self.input = uwu.get_text()
					break
				} else {
					self.args << it
				}
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

	mut flag := self.find_flag(name)!

	if flag.kind != .bool {
		if i + 1 >= args.len {
			return error('missing value for flag ${name}')
		}
		i++
	}
	match flag.kind {
		.bool {
			flag.value = 'true'
		}
		.int {
			val := args[i]
			if !is_numeric(val) {
				return error('unexpected value. expecting an integer')
			}
			flag.value = val
		}
		// TODO .float {}
		.text {
			if flag.wide {
				flag.value = args[i..].join(';')
				i = args.len
			} else {
				// try to unquote...
				mut val := args[i]
				if val.starts_with('"') && val.ends_with('"') {
					val = val[1..val.len - 2]
				}
				flag.value = val
			}
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

	mut flag := self.find_flag('${alias}')!

	if flag.kind != .bool {
		if i + 1 >= args.len {
			return error('missing value for flag -${alias}')
		}
		i++
	}

	match flag.kind {
		.bool {
			flag.value = 'true'
		}
		.int {
			val := args[i]
			if !is_numeric(val) {
				return error('unexpected value. expecting an integer')
			}
			flag.value = val
		}
		// TODO .float {}
		.text {
			if flag.wide {
				flag.value = args[i..].join(';')
				i = args.len
			} else {
				// try to unquote...
				mut val := args[i]
				if val.starts_with('"') && val.ends_with('"') {
					val = val[1..val.len - 2]
				}
				flag.value = val
			}
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
