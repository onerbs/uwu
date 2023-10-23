module cli

import uwu.this
import uwu.style
import uwu.buffer

// version return the version of the App
pub fn (self App) version() string {
	appname := style.tint(this.name, style.bold)
	version := style.tint('v${self.version}', style.dim)
	if appname[0] != this.name[0] {
		return '\n  ${appname}  ${version}\n'
	}
	return '${appname} ${version}'
}

pub fn (self App) usage() string {
	mut buf := buffer.new()

	buf.write('\n  ')
	emblem := style.tag(this.name, style.over_blue)
	buf.write(emblem)
	if buf.last() == `:` {
		buf.trim(buf.len - 1)
		buf.write(' —')
	}
	buf << ` `
	buf.writeln(self.brief)

	buf.write('\x1b[2m') // if supports escape sequences...
	if self.author.len > 0 {
		buf.writeln('   ${self.author}')
	}
	buf.write('   version ')
	buf.writeln(self.version)
	buf.write('\x1b[22m') // if supports escape sequences...

	buf.write('\n  Usage: ${this.name}')

	if self.flags.len > 0 {
		buf.write(' <OPTIONS>')
	}
	for item in self.items {
		buf.write(' [${item}]')
	}

	if self.flags.len > 0 {
		buf.writeln('\n\n  Options:')
		for flag in self.flags {
			buf.writeln('    ${*flag}')
		}
	}
	if self.demos.len > 0 {
		buf.writeln('\n  Examples:')
		for demo in self.demos {
			buf.writeln('    ${demo}')
		}
	}
	if self.notes.len > 0 {
		buf.writeln('\n  Notes:')
		for note in self.notes {
			buf.writeln('    ${note}.')
		}
	}

	return buf.str()
}
