import uwu.buffer

fn test_write() {
	mut buf := buffer.new()
	buf.write('ahoy ')
	buf.write('ahoy')
	assert buf.str() == 'ahoy ahoy'

	buf.write('ahoy')
	assert buf.value() == 'ahoy'
	assert buf.str() == 'ahoy'
	assert buf.value() == ''
}

fn test_writeln() {
	mut buf := buffer.new()
	buf.writeln('ahoy')
	buf.writeln('ahoy')
	assert buf.str() == 'ahoy\nahoy\n'

	buf.writeln('ahoy')
	assert buf.str() == 'ahoy\n'
}
