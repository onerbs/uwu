module flag

pub const (
	flag_help    = Config{
		brief: 'Print this help and exit'
		name: 'help'
		alias: `h`
	}
	flag_version = Config{
		brief: 'Print the release version'
		name: 'version'
		alias: `v`
	}
	flag_quiet   = Config{
		brief: 'Enable the quiet mode'
		name: 'quiet'
		alias: `q`
	}
	flag_stdin   = Config{
		brief: 'Read from the standard input'
		alias: `-`
	}
)
