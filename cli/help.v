module cli

import uwu.put
import uwu.this
import uwu.buffer

// version return the version of the App
pub fn (self App) version() string {
	appname := put.tint(this.name, put.bold)
	version := put.tint('v${self.version}', put.dim)
	if appname[0] != this.name[0] {
		return '\n  ${appname}  ${version}\n'
	}
	return '${appname} ${version}'
}

pub fn (self App) usage() string {
	mut buf := buffer.new()

	buf.write('\n  ')
	emblem := put.tint(this.name, put.blue)
	buf.write(emblem)
	if buf.last() == `:` {
		buf.trim(buf.len - 1)
		buf.write(' —')
	}
	buf << ` `
	buf.writeln(self.brief)

	if put.supports_escape_sequences(C.stderr) {
		buf.write('\e[2m')
	}
	if self.author.len > 0 {
		buf.writeln('  ${self.author}')
	}
	buf.write('  version ')
	buf.writeln(self.version)
	if put.supports_escape_sequences(C.stderr) {
		buf.write('\e[22m')
	}

	buf.write('\n  Usage: ${this.name}')

	if self.flags.len > 0 {
		buf.write(' [<options>]')
	}
	for item in self.items {
		buf.write(' [${item}]')
	}
	if self.items.len > 0 {
		buf << `\n`
	}

	if self.flags.len > 0 {
		buf.writeln('\n  Options:')
		for it in self.flags {
			buf.writeln('    ${*it}')
		}
	}
	if self.demos.len > 0 {
		buf.writeln('\n  Examples:')
		for it in self.demos {
			buf.writeln('    ${it}')
		}
	}
	if self.notes.len > 0 {
		buf.writeln('\n  Notes:')
		for it in self.notes {
			buf.writeln('    ${it}')
		}
	}

	return buf.str()
}
