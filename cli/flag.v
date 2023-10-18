module cli

import uwu.ups

pub enum FlagKind {
	bool
	// float
	int
	text
}

[params]
pub struct FlagConfig {
	name  string
	alias rune
	brief string
	item  string
	wide  bool
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

fn new_flag(cfg FlagConfig, kind FlagKind) Flag {
	if cfg.alias == 0 && cfg.name.len < 1 {
		panic('FatalError: Every flag requires either a name or an alias.')
	}
	return Flag{
		FlagConfig: cfg
		kind: kind
	}
}

type FlagId = rune | string

fn (self Flag) get_id() FlagId {
	if self.name.len > 0 {
		return self.name
	}
	return self.alias
}

const falsy_strings = ['false', '0', 'off', 'no', '']

// bool return the value as a boolean.
pub fn (self Flag) bool_value() bool {
	return !cli.falsy_strings.contains(self.value.to_lower())
}

// // float return the value as a number.
// pub fn (self Flag) float() f64 {
// 	return self.value.f64()
// }

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

// -----------------

// find_flag_by_name return the flag with the specified name.
[direct_array_access]
pub fn (self App) find_flag_by_name(name string) !&Flag {
	for flag in self.flags {
		if flag.name == name {
			return flag
		}
	}
	return ups.unknown('flag', name)
}

// find_flag_by_alias return the flag with the specified alias.
[direct_array_access]
pub fn (self App) find_flag_by_alias(alias rune) !&Flag {
	for flag in self.flags {
		if flag.alias == alias {
			return flag
		}
	}
	return ups.unknown('flag', '-${alias}')
}
