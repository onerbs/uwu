module str

import uwu.buffer

// brace will surround the base string in a brace pair or
// place a bracer at the end and another at the beginning
// of the base string.
pub fn brace(base string, bracer string) string {
	pair := str.braces_s[bracer] or { bracer }
	return '$bracer$base$pair'
}

// brace will surround the base string into.
pub fn brace_mirror(base string, bracer string) string {
	pair := mirror(bracer)
	return '$bracer$base$pair'
}

// digits extract the numeric characters from a string.
pub fn digits(base string) string {
	mut buf := []byte{cap: base.len}
	for c in base {
		if c.is_digit() {
			buf << c
		}
	}
	return buf.bytestr()
}

// grow append the necessary spaces to the end of the provided
// string until the length match the specified size.
pub fn grow(base string, size int) string {
	if size > base.len {
		unsafe {
			gap := size - base.len
			buf := malloc(size)
			vmemcpy(buf, base.str, base.len)
			vmemset(buf + base.len, 0x20, gap)
			return buf.vstring_with_len(size)
		}
	}
	return base
}

// grow_left append the necessary spaces to the beginning of the
// provided string until the length match the specified size.
pub fn grow_left(base string, size int) string {
	if size > base.len {
		unsafe {
			gap := size - base.len
			buf := malloc(size)
			vmemset(buf, 0x20, gap)
			vmemcpy(buf + gap, base.str, base.len)
			return buf.vstring_with_len(size)
		}
	}
	return base
}

// key_value extract a key-value pair from a string.
pub fn key_value(base string, delim string) (string, string) {
	pts := base.split_nth(delim, 2)
	key := pts[0] or { '' }
	val := pts[1] or { '' }
	return key, val
}

// lines extract the lines from a string, trimming white spaces
// and skipping empty lines.
pub fn lines(base string) []string {
	mut res := []string{}
	mut buf := buffer.cap(base.len)
	for c in base {
		if c == `\n` {
			lin := buf.strip()
			if lin.len > 0 {
				res << lin
			}
		} else {
			buf << c
		}
	}
	lin := buf.strip()
	if lin.len > 0 {
		res << lin
	}
	return res
}

// mirror will reverse the base string, also mirroring any
// supported character.
[direct_array_access]
pub fn mirror(base string) string {
	mut buf := []byte{cap: base.len}
	for i := base.len - 1; i >= 0; i-- {
		c := base[i]
		if c in str.braces_b {
			buf << str.braces_b[c]
		} else {
			buf << c
		}
	}
	return buf.bytestr()
}

// quote will surround the provided string in double quotes.
pub fn quote(base string) string {
	return brace(base, '"')
}

// single_quote will surround the provided string in single quotes.
pub fn single_quote(base string) string {
	return brace(base, "'")
}

// safe_quote will surround the provided string in double quotes
// if it contains spaces, escaping the already existing double quotes.
pub fn safe_quote(base string) string {
	if base.contains(' ') {
		return quote(base.replace('"', r'\"'))
	}
	return base
}

// safe_single_quote will surround the provided string in single quotes
// if it contains spaces, escaping the already existing single quotes.
pub fn safe_single_quote(base string) string {
	if base.contains(' ') {
		return single_quote(base.replace("'", r"\'"))
	}
	return base
}

// repeat create a string with len n only containing the
// character c.
pub fn repeat(c byte, n int) string {
	if _unlikely_(n < 1 || c < 1) {
		return ''
	}
	unsafe {
		buf := &byte(vmemset(malloc(n), c, n))
		return buf.vstring_with_len(n)
	}
}

// repeat_string will create a new string with n repetitions
// of the base string.
pub fn repeat_str(base string, n int) string {
	if n < 1 || base.len == 0 {
		return ''
	}
	len := base.len * n
	buf := unsafe { malloc(len) }
	mut ptr := buf
	for _ in 0 .. n {
		unsafe {
			vmemcpy(ptr, base.str, base.len)
			ptr += base.len
		}
	}
	return unsafe { buf.vstring_with_len(len) }
}

// space return the base string with one space between every character.
pub fn space(base string) string {
	if base.len < 1 {
		return ''
	}
	len := base.len * 2
	unsafe {
		mut buf := malloc(len)
		for i in 0 .. base.len {
			ix := i * 2
			buf[ix] = base[i]
			buf[ix + 1] = ` `
		}
		return buf.vstring_with_len(len - 1)
	}
}

// words extract the words from a string.
// i.e. find all matches of the regular expression '\S+'.
pub fn words(base string) []string {
	mut res := []string{}
	mut buf := buffer.cap(base.len)
	for c in base {
		if c.is_space() {
			if buf.len > 0 {
				res << buf.str()
			}
		} else {
			buf << c
		}
	}
	if buf.len > 0 {
		res << buf.str()
	}
	return res
}

const (
	braces_s = {
		'(':  ')'
		'<':  '>'
		'[':  ']'
		'{':  '}'
		'¡': '!'
		'¿': '?'
	}
	braces_b = {
		`(`:  `)`
		`<`:  `>`
		`[`:  `]`
		`{`:  `}`
		`¡`: `!`
		`¿`: `?`
	}
)
