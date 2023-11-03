module cli

import uwu

[inline]
pub fn (mut self App) parse() ! {
	return self.parse_args(uwu.get_args())
}

[direct_array_access]
pub fn (mut self App) parse_args(args []string) ! {
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

	mut rest := []string{}
	mut ix := 0
	for ; ix < args.len; ix++ {
		it := args[ix]
		match it {
			'-' {
				if ix + 1 == args.len && self.with_stdin {
					self.input = uwu.get_text()
				} else {
					rest << it
				}
			}
			'--' {
				if ix + 1 < args.len {
					rest << args[ix + 1..]
				}
				break
			}
			else {
				if it.starts_with('-') {
					id := it.trim_left('-')
					if self.with_help && flag_help.matches(id) {
						return error(self.usage())
					}
					if self.with_version && flag_version.matches(id) {
						return error(self.version())
					}

					if mut flag := self.find_flag(id) {
						if flag.kind != .bool {
							ix++
							if ix >= args.len {
								return ups.missing_value('flag', it)
							}
						}
						match flag.kind {
							.bool {
								flag.value = 'true'
							}
							.int {
								flag.value = args[ix]
							}
							.text {
								if flag.is_wide {
									flag.value = args[ix..].join(';')
									ix = args.len
								} else {
									flag.value = args[ix]
								}
							}
						}
					} else {
						rest << it
					}
				} else {
					rest << it
				}
			}
		}
	}

	for itx in 0 .. self.items.len {
		mut ref := self.items[itx]
		if val := rest[0] {
			ref.value = val
			rest.delete(0)
		} else {
			if !ref.is_optional {
				return ups.missing_value('item', ref.name)
			}
			break
		}
	}

	self.args << rest
}
