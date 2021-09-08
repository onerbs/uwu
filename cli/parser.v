module cli

import uwu.ups
import uwu

// parse
pub fn (mut self App) parse() ? {
	return self.parse_args(uwu.get_args())
}

// parse_args
pub fn (mut self App) parse_args(args []string) ? {
	if args.len < self.need_args {
		ups.not_enough('arguments', self.need_args, args.len) ?
	}

	if self.with_help {
		self.push_flag(flag_help)
	}
	if self.with_version {
		self.push_flag(flag_version)
	}

	mut i := 0
	for ; i < args.len; i++ {
		it := args[i]
		if it == '--' {
			self.args << args[i + 1..]
			break
		} else if it == '-' {
			if self.with_stdin {
				self.input = uwu.get_input()
			} else {
				self.args << it
			}
		} else if it.starts_with('--') {
			mut flag := self.flags.get(it[2..]) ?
			if flag.kind != .bool {
				if i + 1 >= args.len {
					ups.missing_value('flag', it) ?
				}
				i++
			}
			match flag.kind {
				.bool {
					flag.value = 'true'
					continue
				}
				.int {
					value := args[i]
					if !is_numeric(value) {
						ups.unexpected(value, 'an integer') ?
					}
				}
				// TODO .float {}
				.string {
					if flag.wide {
						flag.value = args[i..].join(' ')
						break
					} else {
						flag.value = args[i]
					}
				}
			}
		} else if it.starts_with('-') {
			for b in it[1..] {
				id := rune(b)
				mut flag := self.flags.get('$id') ?
				if self.with_help && flag_help.alias == b {
					return error(self.usage())
				}
				if self.with_version && flag_version.alias == b {
					return error(self.version())
				}
				if flag.kind != .bool {
					if i + 1 >= args.len {
						ups.missing_value('flag', '-$id') ?
					}
					i++
				}
				match flag.kind {
					.bool {
						flag.value = 'true'
						continue
					}
					.int {
						value := args[i]
						if !is_numeric(value) {
							ups.unexpected(value, 'an integer') ?
						}
					}
					// TODO .float {}
					.string {
						if flag.wide {
							flag.value = args[i..].join(' ')
							break
						} else {
							flag.value = args[i]
						}
					}
				}
			}
		} else {
			self.args << it
		}
	}
	for flag in self.flags {
		len := flag.armor().len
		if len > self.metro {
			self.metro = len
		}
	}
}

fn is_numeric(s string) bool {
	for c in s {
		if !c.is_digit() {
			return false
		}
	}
	return true
}
