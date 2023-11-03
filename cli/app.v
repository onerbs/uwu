module cli

[params]
pub struct AppConfig {
	author       Author
	version      string = '0.1.0'
	with_help    bool   = true
	with_version bool   = true
	with_stdin   bool
mut:
	brief string
	demos []string
	notes []string
}

[heap; noinit]
pub struct App {
	AppConfig
mut:
	items []&Item
	flags []&Flag
	args  []string
	input string
	metro int
}

// new create a new App with the provided configuration.
pub fn App.new(cfg AppConfig) App {
	mut app := App{
		AppConfig: cfg
	}
	if app.with_stdin {
		mut ref := flag_stdin
		app.push_flag(mut ref)
	}
	return app
}

// get_args return the application arguments.
[inline]
pub fn (self App) get_args() []string {
	return self.args.clone()
}

// get_input return the content of the standard input.
[inline]
pub fn (self App) get_input() string {
	if self.with_stdin {
		return self.input.clone()
	}
	return self.args.join(' ')
}

// get_lines return the lines from the standard input.
[inline]
pub fn (self App) get_lines() []string {
	return self.get_input().split_into_lines()
}

// ----------------- Items

pub fn (mut self App) item(itm Item) &Item {
	mut ref := itm
	self.items << &ref
	return &ref
}

// ----------------- Flags

// flag create and push a flag with value.
[inline]
pub fn (mut self App) flag(cfg FlagConfig) &Flag {
	mut flag := Flag.new(cfg, .text)
	self.push_flag(mut flag)
	return &flag
}

// bool_flag create and push a boolean flag.
[inline]
pub fn (mut self App) bool_flag(cfg FlagConfig) &Flag {
	mut flag := Flag.new(cfg, .bool)
	self.push_flag(mut flag)
	return &flag
}

// int_flag create and push a flag with numeric value.
[inline]
pub fn (mut self App) int_flag(cfg FlagConfig) &Flag {
	mut flag := Flag.new(cfg, .int)
	self.push_flag(mut flag)
	return &flag
}

// push_flag sets the flag metro and pus it into the application flags.
// fixme: return an error on overlapping identifiers.
[inline]
fn (mut self App) push_flag(mut flag Flag) {
	self.validate(flag) or { panic(err.msg()) }
	flag.metro = &self.metro
	self.flags << flag
}

fn (self App) validate(tgt Flag) ! {
	for flag in self.flags {
		if tgt.alias > 0 && tgt.alias == flag.alias {
			return error_with_code('the "-${flag.alias}" flag is taken.', 3)
		}
		if tgt.name.len > 0 && tgt.name == flag.name {
			return error_with_code('the "--${flag.name}" flag is taken.', 3)
		}
	}
}
