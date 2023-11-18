module flag

pub enum Kind {
	bool
	text
}

@[params]
pub struct Config {
pub:
	kind  Kind = .text
	name  string
	alias rune
	brief string
	item  string
pub mut:
	value string
}

@[heap; noinit]
pub struct Flag {
	Config
pub mut:
	metro &int = unsafe { 0 }
}

pub fn new(cfg Config) Flag {
	if cfg.alias < 1 && cfg.name.len < 1 {
		panic('encountered a flag without identifier')
	}
	return Flag{
		Config: cfg
	}
}

// int return the value as an integer.
@[inline]
pub fn (f Flag) int() int {
	return f.value.int()
}

// bool return the value as a boolean.
@[inline]
pub fn (f Flag) bool() bool {
	return flag.truthy_values.contains(f.value.to_lower())
}

const truthy_values = ['true', 'on', '1', 'yes', 'y']

@[direct_array_access]
pub fn (f Config) matches(id string) bool {
	return match id.len {
		0 { false }
		1 { f.alias == id[0] }
		else { f.name == id }
	}
}
