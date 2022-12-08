import uwu.buffer

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
