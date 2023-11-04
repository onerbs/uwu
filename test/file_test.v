import uwu
import os

fn test_read_bytes() {
	mut rft := uwu.open('test_read_file.txt', 'r')!
	defer {
		rft.close()
	}

	// vfmt off
	assert rft.read_bytes() == [
		u8(`a`), `\n`, `b`, `\n`, `c`, `\n`, `d`, `\n`, `\n`,
		    `0`, `\n`, `1`, `\n`, `2`, `\n`, `3`, `\n`
  ]
	// vfmt on
	assert rft.read_text() == 'a\nb\nc\nd\n\n0\n1\n2\n3\n'
	assert rft.read_lines().len == 10
}

fn test_write_bytes() {
	mut fil := uwu.open('test_write_bytes.txt', 'w')!
	defer {
		fil.close()
	}

	dat := [u8(`A`), `h`, `o`, `y`, `!`, `\n`]
	res := fil.write_bytes(dat) or { 0 }
	assert res > 0, 'a negative result means the operation was unsuccessful'
	assert res == dat.len, 'the write_bytes result should be equals to the data length'
}

fn test_write_text() {
	mut fil := uwu.open('test_write_text.txt', 'w')!
	defer {
		fil.close()
	}

	dat := 'this is a sample text'
	fil.write_text(dat) or { assert false }
}

fn testsuite_end() {
	os.rm('test_write_text.txt')!
	os.rm('test_write_bytes.txt')!
}
