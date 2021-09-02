import uwu.table

fn test_cells() {
	assert crea('a:_d:we:f').cells() == [['a', '', ''], ['d', 'we', 'f']]
	assert crea('::us:x_d:e:f').cells() == [['', '', 'us', 'x'], ['d', 'e', 'f', '']]
	assert crea('::us:_d:e:f').cells() == [['', '', 'us'], ['d', 'e', 'f']]
	assert crea('::us::_d:e:f').cells() == [['', '', 'us'], ['d', 'e', 'f']]
	assert crea('a::c_d:we:f').cells() == [['a', '', 'c'], ['d', 'we', 'f']]
	assert crea('a::c:_d:we:f:').cells() == [['a', '', 'c'], ['d', 'we', 'f']]
}

fn test_lines() {
	assert crea('a:_d:we:f').lines() == ['a', 'd  we  f']
	assert crea('::us:x_d:e:f').lines() == ['      us  x', 'd  e  f']
	assert crea('::us:_d:e:f').lines() == ['      us', 'd  e  f']
	assert crea('::us::_d:e:f').lines() == ['      us', 'd  e  f']
	assert crea('a::c_d:we:f').lines() == ['a      c', 'd  we  f']
	assert crea('a::c:_d:we:f:').lines() == ['a      c', 'd  we  f']
}

const cfg = table.new(rd: '_')

fn crea(source string) table.Table {
	return cfg.source(source)
}
