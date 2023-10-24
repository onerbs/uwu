import uwu.paths

fn test_simple() {
	assert 'uwu.c' == paths.simple('some/uwu.c.v')
	assert 'uwu' == paths.simple('some/uwu.v')
}

fn test_chext() {
	assert 'some/uwu.c' == paths.chext('some/uwu.c.v', '')
	assert 'some/uwu.c' == paths.chext('some/uwu.v', '.c')
	assert 'some/uwu.c' == paths.chext('some/uwu', 'c ')
	assert 'uwu.c' == paths.chext('uwu', 'c')
}
