import uwu

fn test_read_bytes() {
	mut rft := uwu.open('read_file_test.txt', 'r')!

	assert rft.read_bytes() == [u8(`a`), `\n`, `b`, `\n`, `c`, `\n`, `d`, `\n`, `\n`, `0`, `\n`,
		`1`, `\n`, `2`, `\n`, `3`, `\n`]
	assert rft.read_text() == 'a\nb\nc\nd\n\n0\n1\n2\n3\n'
	assert rft.read_lines().len == 10
	rft.close()
}

fn test_write_bytes() {
	mut wft := uwu.open('write_file_test.txt', 'w')!

	dat := [u8(`A`), `h`, `o`, `y`, `!`, `\n`]
	wft.write_bytes(dat)
	wft.close()

	wft = uwu.open('write_file_test.txt', 'r')!
	assert dat == wft.read_bytes()
	wft.close()
}
