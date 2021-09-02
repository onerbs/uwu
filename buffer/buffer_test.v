import uwu.buffer

fn test_peek() {
	mut buf := buffer.cap(10)
	buf.write('0123456789')
	assert buf.value() == '0123456789'
	assert buf.peek(5, 5) == '56789'
	assert buf.peek(-5, 5) == '01234'
	assert buf.peek(-8, 5) == '01234'
	assert buf.peek(5, 10) == '56789'
	assert buf.peek(10, 5) == ''
}

fn test_strip() {
	mut buf := buffer.new()
	buf.write('  \tahoy\n\n\t  \v')
	assert buf.strip() == 'ahoy'
	assert buf.value() == ''

	buf.write('  \t\n\n\t  \v')
	assert buf.strip() == ''
	assert buf.value() == ''
}

fn test_cut_first() {
	mut buf := buffer.new()
	buf.write('hello, darling')
	assert buf.cut_first(7) == 'hello, '
	assert buf.str() == 'darling'
	assert buf.str() == ''
}

fn test_cut_last() {
	mut buf := buffer.new()
	buf.write('hello, darling')
	assert buf.cut_last(9) == ', darling'
	assert buf.str() == 'hello'
}

fn test_drop_first() {
	mut buf := buffer.new()
	buf.write('hello, darling')
	buf.drop_first(1)
	assert buf.value() == 'ello, darling'
	buf.drop_first(1000)
	assert buf.value() == ''
	assert buf.len == 0
}

fn test_index() {
	mut buf := buffer.new()
	buf.write('hello, darling')
	assert 5 == buf.index(', ')
	assert 0 == buf.index('hello')
	assert 7 == buf.index('darling')
	assert -1 == buf.index('love')
	assert -1 == buf.index('some random text')
	assert -1 == buf.index('')
}

fn test_last_index() {
	mut buf := buffer.new()
	buf.write('hello, darling')
	assert 0x0 == buf.last_index('hello')
	assert 0xa == buf.last_index('l')
	assert 0xb == buf.last_index('ing')
	assert 0xc == buf.last_index('ng')
	assert 0xd == buf.last_index('g')
	assert -1 == buf.last_index('love')
	assert -1 == buf.last_index('some random text')
	assert -1 == buf.last_index('')
}

fn test_write() {
	mut buf := buffer.new()
	buf.write('ahoy ')
	buf.write('mane')
	assert buf.str() == 'ahoy mane'

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
