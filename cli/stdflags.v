module cli

pub const (
	flag_stdin   = bool_flag(
		brief: 'Read from the standard input'
		alias: `-`
	)
	flag_quiet   = bool_flag(
		brief: 'Enable the quiet mode'
		name: 'quiet'
		alias: `q`
	)
	flag_debug   = bool_flag(
		brief: 'Enable the debug mode'
		name: 'debug'
		alias: `D`
	)
	flag_verbose = bool_flag(
		brief: 'Enable the verbose mode'
		name: 'verbose'
		alias: `v`
	)
	flag_help    = bool_flag(
		brief: 'Print this help and exit'
		name: 'help'
		alias: `h`
	)
	flag_version = bool_flag(
		brief: 'Print the release version'
		name: 'version'
		alias: `V`
	)
)

// bool_flag create a new boolean flag
[inline]
fn bool_flag(cfg FlagConfig) Flag {
	return new_flag(cfg, .bool)
}
