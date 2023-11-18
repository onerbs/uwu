module app

import uwu
import uwu.cli.flag

@[inline]
pub fn (mut self App) parse() ! {
	return self.parse_args(uwu.get_args())
}

@[direct_array_access]
pub fn (mut self App) parse_args(args []string) ! {
	if self.with_help {
		self.flag(flag.help)
	}
	if self.with_version {
		self.flag(flag.version)
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
					if self.with_help && flag.help.matches(id) {
						return error(self.usage())
					}
					if self.with_version && flag.version.matches(id) {
						return error(self.version())
					}
					if mut flag := self.find_flag(id) {
						match flag.kind {
							.bool {
								flag.value = 'true'
							}
							.text {
								ix++
								if ix >= args.len {
									return error('flag "${it}" not found')
								}
								flag.value = args[ix]
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

	// for itx in 0 .. self.items.len {
	// 	mut ref := self.items[itx]
	// 	if val := rest[0] {
	// 		ref.value = val
	// 		rest.delete(0)
	// 	} else {
	// 		if !ref.is_optional {
	// 			return ups.missing_value('item', ref.name)
	// 		}
	// 		break
	// 	}
	// }

	self.args << rest
}
