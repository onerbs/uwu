module cli

import uwu.ups

enum FlagKind {
	bool
	// float
	int
	string
}

pub struct FlagType {
pub:
	brief string
	name  string
	alias rune
	item  string
	wide  bool
mut:
	value string
}

[heap]
pub struct Flag {
	FlagType
pub:
	kind FlagKind [required]
mut:
	metro &int = 0
}

pub fn (self &Flag) string() string {
	return self.value
}

pub fn (self &Flag) bool() bool {
	return self.value == 'true'
}

// pub fn (self &Flag) f64() f64 {
// 	return self.value.f64()
// }

pub fn (self &Flag) int() int {
	return self.value.int()
}

pub fn (ary []&Flag) get(id string) ?&Flag {
	for flag in ary {
		if id.len == 1 {
			if flag.alias == id[0] {
				return flag
			}
		} else {
			if flag.name == id {
				return flag
			}
		}
	}
	ups.unknown('flag', id) ?
	return none // unreachable.
}
