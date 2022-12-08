import uwu.buffer

fn test_peek() {
	mut buf := buffer.cap(10)
	buf.write('0123456789')
	assert buf.value() == '0123456789'
	assert buf.peek(5, 5) == '56789'
	assert buf.peek(-5, 5) == '56789'
	assert buf.peek(-8, 5) == '23456'
	assert buf.peek(5, 10) == '56789'
	assert buf.peek(10, 5) == ''
}

// fn test_get_first() {}

// fn test_get_last() {}

fn test_cut_first() {
	mut buf := buffer.new()
	buf.write('hello, hello')
	assert buf.cut_first(7) == 'hello, '
	assert buf.str() == 'hello'
	assert buf.len == 0
}

fn test_cut_last() {
	mut buf := buffer.new()
	buf.write('hello, hello')
	assert buf.cut_last(7) == ', hello'
	assert buf.str() == 'hello'
	assert buf.len == 0
}

fn test_drop_first() {
	mut buf := buffer.new()
	buf.write('hello, hello')
	buf.drop_first(1)
	assert buf.value() == 'ello, hello'
	buf.drop_first(1000)
	assert buf.value() == ''
	assert buf.len == 0
}

// fn test_drop_last() {}
