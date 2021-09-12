module cli

pub struct AppConfig {
	version string = '0.1.0'
	item         string
	is_optional  bool
	with_help    bool = true
	with_stdin   bool = true
	with_version bool = true
	// todo: fail on unrecognized flags.
	strict       bool
mut:
	need_args    int = -1
	brief string
	demos []string
	notes []string
}

struct App {
	AppConfig
mut:
	input     string
	// todo: implement memory.
	// memory map[string]string
	args  []string
	flags []&Flag
	metro int
}

// todo: fail if any flag id overlaps.
// -----------------

// new_app create a new App with the provided configuration.
pub fn new_app(cfg AppConfig) &App {
	mut app := &App{
		AppConfig: cfg
	}
	if app.with_stdin {
		app.push_flag(flag_stdin)
	}
	if app.need_args < 0
	&& app.item.len > 0
	&& !app.is_optional {
		app.need_args = 1
	}
	return app
}

// get_args return the application arguments.
pub fn (self App) get_args() []string {
	return self.args
}

// get_input return the content of the standard input.
pub fn (self App) get_input() string {
	if self.with_stdin {
		return self.input
	}
	return self.args.join(' ')
}

// get_lines return the lines from the standard input.
pub fn (self App) get_lines() []string {
	return self.get_input().split_into_lines()
}

// -----------------

// flag create and push a flag with value.
pub fn (mut self App) flag(it FlagType) &Flag {
	flag := &Flag{
		FlagType: it
		kind: .string
		metro: &self.metro
	}
	self.flags << flag
	return flag
}

// bool_flag create and push a boolean flag.
pub fn (mut self App) bool_flag(it FlagType) &Flag {
	flag := &Flag{
		FlagType: it
		kind: .bool
		metro: &self.metro
	}
	self.flags << flag
	return flag
}

// // float_flag create and push a flag with numeric value.
// pub fn (mut self App) float_flag(it FlagType) &Flag {
// 	flag := &Flag{
// 		FlagType: it
// 		kind: .float
//		metro: &self.metro
// 	}
// 	self.flags << flag
// 	return flag
// }

// int_flag create and push a flag with numeric value.
pub fn (mut self App) int_flag(it FlagType) &Flag {
	flag := &Flag{
		FlagType: it
		kind: .int
		metro: &self.metro
	}
	self.flags << flag
	return flag
}

// push_flag sets the flag metro and pus it into the application flags.
fn (mut self App) push_flag(it &Flag) {
	unsafe {
		mut flag := it
		flag.metro = &self.metro
		self.flags << flag
	}
}
