import uwu.str

fn test_brace() {
	assert str.brace('ahoy', '"') == '"ahoy"'
	assert str.brace('ahoy', '(') == '(ahoy)'
	assert str.brace('ahoy', '¡') == '¡ahoy!'
	assert str.brace('ahoy', 'X') == 'XahoyX'
}

fn test_digits() {
	assert str.digits('ns834v389vb2') == '8343892'
}

fn test_key_value() {
	mut a, mut b := str.key_value('a = b', ' = ')
	assert a == 'a'
	assert b == 'b'

	a, b = str.key_value('c: no', ': ')
	assert a == 'c'
	assert b == 'no'

	a, b = str.key_value('some', ' = ')
	assert a == 'some'
	assert b == ''
}

fn test_repeat_str() {
	assert 'aaaaaa' == str.repeat_str('aa', 3)
}

fn test_safe_quote() {
	assert 'something' == str.safe_quote('something')
	assert '"one two three"' == str.safe_quote('one two three')
	assert r'"one \"two\" three"' == str.safe_quote('one "two" three')
}

fn test_space() {
	assert 'a b c d' == str.space('abcd')
	assert '' == str.space('')
}

fn test_words() {
	assert str.words('abc bd  c. \xA0 \n d') == ['abc', 'bd', 'c.', 'd']
}

fn test_mirror() {
	assert str.mirror(' ( ') == ' ) '
	assert str.mirror('[[E') == 'E]]'
	assert str.mirror('what') == 'tahw'
}
