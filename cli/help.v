module cli

import uwu.style
import uwu.host
import uwu.buffer { Buffer }

// version return the version of the App
pub fn (self App) version() string {
	appname := style.tint(host.app_name, style.bold)
	version := style.tint('v${self.version}', style.dim)
	if appname[0] != host.app_name[0] {
		return '\n  ${appname}  ${version}\n'
	}
	return '${appname} ${version}'
}

pub fn (self App) usage() string {
	mut buf := Buffer.new()

	buf.write('\n  ')
	emblem := style.tag(host.app_name, style.over_blue)
	buf.write(emblem)
	if buf.last() == `:` {
		buf.trim(buf.len - 1)
		buf.write(' —')
	}
	buf << ` `
	buf.writeln(self.brief)

	buf.write('\x1b[2m') // if supports escape sequences...
	if self.author.name.len > 0 {
		buf.writeln('   ${self.author}')
	}
	buf.write('   version ')
	buf.writeln(self.version)
	buf.write('\x1b[22m') // if supports escape sequences...

	buf.write('\n  Usage: ${host.app_name}')

	if self.flags.len > 0 {
		buf.write(' [options]')
	}
	for item in self.items {
		buf.write(' ${*item}')
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
