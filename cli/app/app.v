module app

import uwu.cli.flag

[params]
pub struct AppConfig {
	author       Author
	version      string = '1.0.0'
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
	args  []string
	flags []&flag.Flag
	// items []&Item
	input string
	metro int
}

// new create a new App with the provided configuration.
pub fn new(cfg AppConfig) App {
	mut app := App{
		AppConfig: cfg
	}
	if app.with_stdin {
		app.add_flag(flag.flag_stdin)
	}
	return app
}

// get_args return the application arguments.
[inline]
pub fn (app App) get_args() []string {
	return app.args.clone()
}

// get_input return the content of the standard input.
[inline]
pub fn (app App) get_input() string {
	if app.with_stdin {
		return app.input.clone()
	}
	return app.args.join(' ')
}
