import uwu.buffer

fn test_strip() {
	mut buf := buffer.new()
	buf.write('  \tahoy\n\n\t  \v')
	assert buf.strip() == 'ahoy'
	assert buf.value() == ''

	buf.write('  \t\n\n\t  \v')
	assert buf.strip() == ''
	assert buf.value() == ''
}
