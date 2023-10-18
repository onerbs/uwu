module cli

[params]
pub struct AppConfig {
	author       string
	version      string = '0.1.0'
	with_help    bool   = true
	with_stdin   bool   = true
	with_version bool   = true
mut:
	// todo: remove `need_args` and infer from `.items`
	need_args int = -1
	brief     string
	demos     []string
	notes     []string
}

[noinit]
pub struct App {
	AppConfig
mut:
	// todo: use uwu.buffer.Buffer for input
	input string
	items []string
	flags []&Flag
	args  []string
	metro int
}

// new_app create a new App with the provided configuration.
pub fn new_app(cfg AppConfig) App {
	mut app := App{
		AppConfig: cfg
	}
	if app.with_stdin {
		mut ref := flag_stdin
		app.push_flag(mut ref)
	}
	// fixme: NO_NEED_ARGS
	// if app.need_args < 0 {
	// 	len := app.items.map(it.required).len
	// 	if len > 0 {
	// 		app.need_args = len
	// 	}
	// }
	return app
}

// get_args return the application arguments.
[inline]
pub fn (self App) get_args() []string {
	return self.args.clone()
}

// get_input return the content of the standard input.
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

// ----------------- Flags

// flag create and push a flag with value.
pub fn (mut self App) flag(cfg FlagConfig) Flag {
	mut f := new_flag(cfg, .text)
	return self.push_flag(mut f)
}

// bool_flag create and push a boolean flag.
pub fn (mut self App) bool_flag(cfg FlagConfig) Flag {
	mut f := new_flag(cfg, .bool)
	return self.push_flag(mut f)
}

// int_flag create and push a flag with numeric value.
pub fn (mut self App) int_flag(cfg FlagConfig) Flag {
	mut f := new_flag(cfg, .int)
	return self.push_flag(mut f)
}

// push_flag sets the flag metro and pus it into the application flags.
// fixme: return an error on overlapping identifiers.
fn (mut self App) push_flag(mut flag Flag) Flag {
	self.validate(flag) or { panic(err.msg()) }
	flag.metro = &self.metro
	self.flags << flag
	return flag
}

fn (self App) validate(target Flag) ! {
	for flag in self.flags {
		if target.alias > 0 && target.alias == flag.alias {
			return error('the "-${flag.alias}" flag is taken.')
		}
		if target.name.len > 0 && target.name == flag.name {
			return error('the "--${flag.name}" flag is taken.')
		}
	}
}
