import uwu.str

fn test_brace() {
	assert str.brace('', '') == ''
	assert str.brace('', '"') == '""'
	assert str.brace('ahoy', '"') == '"ahoy"'
	assert str.brace('ahoy', '(') == '(ahoy)'
	assert str.brace('ahoy', '¡') == '¡ahoy!'
	assert str.brace('ahoy', 'X') == 'XahoyX'
}

fn test_digits() {
	assert str.digits('') == ''
	assert str.digits('nsvvsfhbdufx') == ''
	assert str.digits('ns834v389vb2') == '8343892'
}

fn test_grow() {
	assert str.grow('some', 0) == 'some'
	assert str.grow('some', 10) == 'some      '
	assert str.grow('some', -10) == 'some'
	assert str.grow('', 0) == ''
	assert str.grow('', 10) == '          '
	assert str.grow('', -10) == ''
}

fn test_grow_left() {
	assert str.grow_left('some', 0) == 'some'
	assert str.grow_left('some', 10) == '      some'
	assert str.grow_left('some', -10) == 'some'
	assert str.grow_left('', 0) == ''
	assert str.grow_left('', 10) == '          '
	assert str.grow_left('', -10) == ''
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

fn test_lines() {
	assert str.lines('') == []string{}
	assert str.lines('a\nb\r\nc\n\n d  \n\n') == ['a', 'b', 'c', 'd']
}

fn test_mirror() {
	assert str.mirror(' ( ') == ' ) '
	assert str.mirror('[[E') == 'E]]'
	assert str.mirror('what') == 'tahw'
}

fn test_quote() {
	assert str.quote('') == '""'
	assert str.quote('some') == '"some"'
	assert str.quote('some text') == '"some text"'
	assert str.quote('some "other" text') == '"some "other" text"'
}

fn test_single_quote() {
	assert str.single_quote('') == "''"
	assert str.single_quote('some') == "'some'"
	assert str.single_quote('some text') == "'some text'"
	assert str.single_quote("some 'other' text") == "'some 'other' text'"
}

fn test_safe_quote() {
	assert str.safe_quote('') == ''
	assert str.safe_quote('some') == 'some'
	assert str.safe_quote('some text') == '"some text"'
	assert str.safe_quote('some "other" text') == r'"some \"other\" text"'
}

fn test_safe_single_quote() {
	assert str.safe_single_quote('') == ''
	assert str.safe_single_quote('some') == 'some'
	assert str.safe_single_quote('some text') == "'some text'"
	assert str.safe_single_quote("some 'other' text") == r"'some \'other\' text'"
}

fn test_repeat() {
	assert str.repeat(0, 6) == ''
	assert str.repeat(`a`, 6) == 'aaaaaa'
}

fn test_repeat_str() {
	assert str.repeat_str('', 3) == ''
	assert str.repeat_str('aa', 3) == 'aaaaaa'
}

fn test_space() {
	assert str.space('') == ''
	assert str.space('abcd') == 'a b c d'
}

fn test_words() {
	assert str.words('') == []string{}
	assert str.words('abc bd  c. \xA0 \n d') == ['abc', 'bd', 'c.', 'd']
}
