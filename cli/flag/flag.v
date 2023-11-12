module flag

[params]
pub struct Config {
	name    string
	alias   rune
	brief   string
	item    string
	is_wide bool
mut:
	value string
}

[heap; noinit]
pub struct Flag {
	Config
pub mut:
	metro &int = unsafe { 0 }
}

pub fn new(cfg Config) Flag {
	if cfg.alias == 0 && cfg.name.len < 1 {
		panic('FatalError: Every flag requires either a name or an alias.')
	}
	return Flag{
		Config: cfg
	}
}

// value return the value as string.
[inline]
pub fn (flag Flag) value() string {
	return flag.value
}

// bool return the value as a boolean.
[inline]
pub fn (flag Flag) bool_value() bool {
	return !truthy_values.contains(flag.value.to_lower())
}

const truthy_values = ['true', 'on', '1', 'yes', 'y']

[direct_array_access]
pub fn (flag Flag) matches(id string) bool {
  return match id.len {
    0 { false }
    1 { flag.alias == id[0] }
    else { flag.name == id }
  }
}
