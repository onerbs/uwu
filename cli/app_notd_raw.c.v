module cli

import term

import uwu.this
import uwu.buffer

pub fn (self App) str() string {
	mut buf := buffer.new()
	buf << `\n`
	buf << ` `
	buf << ` `
	buf.write(term.highlight_command(this.prog.name))
	if !term.can_show_color_on_stdout {
		buf.write(' —')
	}
	buf << ` `
	buf.writeln(self.brief)
	for _ in 0 .. 60 - (self.version.len + 10) {
		buf << ` `
	}
	buf.writeln(dim('version ' + self.version))
	buf.write(self.usage())
	return buf.str()
}

fn dim(text string) string {
	return term.colorize(term.dim, text)
}
