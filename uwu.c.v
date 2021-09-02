module uwu

import ups
import put
import buffer

// get_input read data from the standard input.
pub fn get_bytes() []byte {
	mut buf := []byte{cap: 0x200}
	for {
		c := C.getchar()
		if c < 0 {
			break
		}
		buf << byte(c)
	}
	return buf
}

// get_input read data from the standard input.
// trailing white spaces are trimmed from the result.
pub fn get_input() string {
	mut buf := buffer.new()
	for {
		c := C.getchar()
		if c < 0 {
			break
		}
		buf << byte(c)
	}
	return buf.strip()
}

// get_lines read all lines from the standard input.
// trailing white spaces are trimmed from every line.
// the result does not contains empty lines.
pub fn get_lines() []string {
	mut buf := buffer.new()
	mut res := []string{}
	for {
		c := C.getchar()
		if c < 0 {
			break
		}
		if c == `\n` {
			s := buf.strip()
			if s.len > 0 {
				res << s
			}
		} else {
			buf << byte(c)
		}
	}
	return res
}

// get_input_from will read the standard input only if `args`
// contains a single dash alone (['-']), otherwise return
// the argument list as a single string.
pub fn get_input_from(args []string) string {
	if args == ['-'] {
		return get_input()
	}
	return args.join(' ')
}

// get_lines_from will read the standard input lines only
// if `args` contains a single dash alone (['-']), otherwise
// return the argument list.
pub fn get_lines_from(args []string) []string {
	if args == ['-'] {
		return get_lines()
	}
	return args
}

fn C.fgetc(&C.FILE) int

// read_file read the content of the given file.
// trailing white spaces are trimmed from the result.
pub fn read_file(path string) ?string {
	fp := fopen(path, 'r') ?
	defer {
		C.fclose(fp)
	}
	mut buf := buffer.new()
	for {
		c := C.fgetc(fp)
		if c < 0 {
			break
		}
		buf << byte(c)
	}
	return buf.strip()
}

// read_file read the lines of the given file.
// trailing white spaces are trimmed from every line.
// the result does not contains empty lines.
pub fn read_lines(path string) ?[]string {
	fp := fopen(path, 'r') ?
	defer {
		C.fclose(fp)
	}
	mut buf := buffer.new()
	mut res := []string{}
	for {
		c := C.fgetc(fp)
		if c < 0 {
			break
		}
		if c == `\n` {
			s := buf.strip()
			if s.len > 0 {
				res << s
			}
		} else {
			buf << byte(c)
		}
	}
	if buf.len > 0 {
		res << buf.strip()
	}
	return res
}

// append_file will write the data at the end of the specified file.
pub fn append_file(path string, data string) ?int {
	return fwrite(path, 'a', data.str, data.len)
}

// append_lines will write the lines at the end of the specified file.
pub fn append_lines(path string, data []string) ?int {
	return append_file(path, data.join_lines())
}

// write_file will write into the specified file overwriting the content.
pub fn write_file(path string, data string) ?int {
	return fwrite(path, 'w', data.str, data.len)
}

// write_lines will write the lines into the specified file
// overwriting the content.
pub fn write_lines(path string, data []string) ?int {
	return write_file(path, data.join_lines())
}

fn fwrite(path string, mode string, data &byte, len int) ?int {
	fp := fopen(path, mode) ?
	defer {
		C.fclose(fp)
	}
	if len == 0 {
		return 0
	}
	size := int(C.fwrite(data, 1, len, fp))
	if size < len {
		$if debug {
			put.info('size: $size; len: $len')
		}
		ups.cannot('write', path) ?
	}
	return size
}

// @see os.vfopen
fn fopen(path string, mode string) ?&C.FILE {
	mut fp := voidptr(0)
	$if windows {
		fp = C._wfopen(path.to_wide(), mode.to_wide())
	} $else {
		fp = C.fopen(&char(path.str), &char(mode.str))
	}
	if isnil(fp) {
		ups.cannot('open', path) ?
	}
	return fp
}
