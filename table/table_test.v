import uwu.table

fn test_cells() {
	assert crea('a:_d:we:f').cells() == [['a', '', ''], ['d', 'we', 'f']]
	assert crea(':u:x_d:e').cells() == [['', 'u', 'x'], ['d', 'e', '']]
	assert crea('::u:_d:e:f').cells() == [['', '', 'u'], ['d', 'e', 'f']]
	assert crea('::u::_d:e:f').cells() == [['', '', 'u'], ['d', 'e', 'f']]
	assert crea('a::c_d:we:f').cells() == [['a', '', 'c'], ['d', 'we', 'f']]
	assert crea('a::c:_d:we:f:').cells() == [['a', '', 'c'], ['d', 'we', 'f']]
}

fn test_lines() {
	assert crea('a:_d:we:f').lines() == ['a', 'd  we  f']
	assert crea('::u:x_d:e:f').lines() == ['      u  x', 'd  e  f']
	assert crea('::u:_d:e:f').lines() == ['      u', 'd  e  f']
	assert crea('::u::_d:e:f').lines() == ['      u', 'd  e  f']
	assert crea('a::c_d:we:f').lines() == ['a      c', 'd  we  f']
	assert crea('a::c:_d:we:f:').lines() == ['a      c', 'd  we  f']
	assert crea('a::c:__d:we:f:').lines() == ['a      c', '', 'd  we  f']
}

const cfg = table.config(rd: '_')

fn crea(source string) table.Table {
	return cfg.source(source)
}
