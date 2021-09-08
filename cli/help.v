module cli

import uwu.this
import uwu.buffer

// version return the version of the App
pub fn (self App) version() string {
	return '\n  $this.prog.name  version $self.version\n'
}

// usage return the usage of the App
pub fn (self App) usage() string {
	mut buf := buffer.new()
	buf.write('\n  Usage: $this.prog.name')

	if self.flags.len > 0 {
		if self.item.len > 0 {
			buf.write(' [<options>]')
			if self.is_optional {
				buf.writeln(' [<$self.item>]')
			} else {
				buf.writeln(' <$self.item>')
			}
		} else {
			buf.writeln(' [<options>]')
		}
		buf.writeln('\n  Options:')
		for it in self.flags {
			buf.writeln('    ${*it}')
		}
	}

	if self.demos.len > 0 {
		buf.writeln('\n  Examples:')
		for it in self.demos {
			buf.writeln('    $it')
		}
	}

	if self.notes.len > 0 {
		buf.writeln('\n  Notes:')
		for it in self.notes {
			buf.writeln('    $it')
		}
	}

	return buf.str()
}
