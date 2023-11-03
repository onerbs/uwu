module cli

import uwu.buffer

pub enum FlagKind {
	bool
	int
	text
}

[params]
pub struct FlagConfig {
	name    string
	alias   rune
	brief   string
	item    string
	is_wide bool
pub mut:
	value string
}

[heap; noinit]
pub struct Flag {
	FlagConfig
	kind FlagKind [required]
mut:
	metro &int = unsafe { 0 }
}

fn Flag.new(cfg FlagConfig, kind FlagKind) Flag {
	if cfg.alias == 0 && cfg.name.len < 1 {
		panic('FatalError: Every flag requires either a name or an alias.')
	}
	return Flag{
		FlagConfig: cfg
		kind: kind
	}
}

const falsy_strings = ['false', '0', 'off', 'no', '']

// bool return the value as a boolean.
[inline]
pub fn (self Flag) bool_value() bool {
	val := self.value.to_lower()
	return !cli.falsy_strings.contains(val)
}

// int return the value as an integer.
[inline]
pub fn (self Flag) int_value() int {
	return self.value.int()
}

// value return the value as string.
[inline]
pub fn (self Flag) value() string {
	return self.value.clone()
}

// values return the flag values as a string list.
[inline]
pub fn (self Flag) values() []string {
	return self.value.split(';')
}

// -----------------

// find_flag return the flag with the specified id.
pub fn (self App) find_flag(id string) ?&Flag {
	for flag in self.flags {
		if flag.matches(id) {
			return flag
		}
	}
	return none
}

[direct_array_access]
fn (self Flag) matches(id string) bool {
	match id.len {
		0 {}
		1 {
			if self.alias == id[0] {
				return true
			}
		}
		else {
			if self.name == id {
				return true
			}
		}
	}
	armor := if id.len == 1 { '-${id}' } else { '--${id}' }
	return error('unknown flag ${armor}')
}

pub fn (self &Flag) armor() string {
	mut buf := buffer.cap(0x20)
	if self.name.len > 0 {
		buf << `-`
		buf << `-`
		buf.write(self.name)
	}
	if self.alias > 0 {
		if buf.len > 0 {
			buf << `,`
			buf << ` `
		}
		if self.alias != `-` {
			buf << `-`
		}
		buf << u8(self.alias)
	}
	if self.item.len > 0 {
		buf << ` `
		buf << `<`
		buf.write(self.item)
		buf << `>`
	}
	return buf.str()
}
