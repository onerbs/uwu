module app

import uwu.style
import uwu.host
import uwu.buffer

pub fn (app App) usage() string {
	mut buf := buffer.new()

	buf.write('\n  ')
	emblem := style.tag(host.app_name, .over_blue)
	buf.write(emblem)
	if buf.last() == `:` {
		buf.trim(buf.len - 1)
		buf.write(' —')
	}
	buf << ` `
	buf.writeln(app.brief)

	buf.write('\x1b[2m') // if supports escape sequences...
	if app.author.name.len > 0 {
		buf.writeln('   ${app.author}')
	}
	buf.write('   version ')
	buf.writeln(app.version)
	buf.write('\x1b[22m') // if supports escape sequences...

	buf.write('\n  Usage: ${host.app_name}')

	if app.flags.len > 0 {
		buf.write(' [options]')
	}
	// for item in app.items {
	// 	buf.write(' ${*item}')
	// }

	if app.flags.len > 0 {
		buf.writeln('\n\n  Options:')
		for flag in app.flags {
			buf.writeln('    ${*flag}')
		}
	}
	if app.demos.len > 0 {
		buf.writeln('\n  Examples:')
		for demo in app.demos {
			buf.writeln('    ${demo}')
		}
	}
	if app.notes.len > 0 {
		buf.writeln('\n  Notes:')
		for note in app.notes {
			buf.writeln('    ${note}.')
		}
	}

	return buf.str()
}

// version return the version of the App
pub fn (app App) version() string {
	nam := style.tint(host.app_name, .bold)
	ver := style.tint('v${app.version}', .dim)
	return '${nam} ${ver}'
}
