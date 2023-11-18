module flag

pub const (
	help = Config{
		kind: .bool
		brief: 'Print this help and exit'
		name: 'help'
		alias: `h`
	}
	version = Config{
		kind: .bool
		brief: 'Print the release version'
		name: 'version'
		alias: `v`
	}
	quiet = Config{
		kind: .bool
		brief: 'Enable the quiet mode'
		name: 'quiet'
		alias: `q`
	}
	stdin = Config{
		kind: .bool
		brief: 'Read from the standard input'
		alias: `-`
	}
)
