module str

import uwu.buffer

// brace will surround the base string in a brace pair or
// place a bracer at the end and another at the beginning
// of the base string.
pub fn brace(s string, bracer string) string {
	pair := str.braces_s[bracer] or { bracer }
	return '${bracer}${s}${pair}'
}

// brace will surround the base string into.
pub fn brace_mirror(s string, bracer string) string {
	pair := mirror(bracer)
	return '${bracer}${s}${pair}'
}

// digits extract the numeric characters from a string.
pub fn digits(s string) string {
	mut buf := buffer.cap(s.len)
	for c in s {
		if c.is_digit() {
			buf << c
		}
	}
	return buf.str()
}

// grow append the necessary spaces to the end of the provided
// string until the length match the specified size.
pub fn grow(s string, size int) string {
	if size <= s.len {
		return s
	}
	gap := size - s.len
	unsafe {
		buf := &u8(malloc(size))
		vmemcpy(buf, s.str, s.len)
		vmemset(buf + s.len, 0x20, gap)
		return buf.vstring_with_len(size)
	}
}

// grow_left append the necessary spaces to the beginning of the
// provided string until the length match the specified size.
pub fn grow_left(s string, size int) string {
	if size <= s.len {
		return s
	}
	gap := size - s.len
	unsafe {
		buf := &u8(malloc(size))
		vmemset(buf, 0x20, gap)
		vmemcpy(buf + gap, s.str, s.len)
		return buf.vstring_with_len(size)
	}
}

// key_value extract a key-value pair from a string.
pub fn key_value(s string, delimiter string) (string, string) {
	pts := s.split_nth(delimiter, 2)
	key := pts[0] or { '' }
	val := pts[1] or { '' }
	return key, val
}

// lines extract the lines from a string, trimming white spaces
// and skipping empty lines.
pub fn lines(s string) []string {
	mut buf := buffer.cap(s.len)
	mut res := []string{}
	for c in s {
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
pub fn mirror(s string) string {
	mut buf := buffer.cap(s.len)
	for i := s.len - 1; i >= 0; i-- {
		c := s[i]
		if c in str.braces_b {
			buf << str.braces_b[c]
		} else {
			buf << c
		}
	}
	return buf.str()
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
pub fn repeat(c u8, n int) string {
	if c < 1 || n < 1 {
		return ''
	}
	unsafe {
		buf := &u8(malloc(n + 1))
		buf[n] = 0
		assert !isnil(vmemset(buf, c, n))
		return buf.vstring_with_len(n)
	}
}

// repeat_string will create a new string with n repetitions
// of the base string.
pub fn repeat_str(s string, n int) string {
	len := s.len * n
	mut ofs := 0
	unsafe {
		buf := &u8(malloc(len + 1))
		for _ in 0 .. n {
			assert !isnil(vmemcpy(buf + ofs, s.str, s.len))
			ofs += s.len
		}
		buf[len] = 0
		return buf.vstring_with_len(len)
	}
}

// space return the base string with one space between every character.
pub fn space(s string) string {
	if s.len < 1 {
		return ''
	}
	len := (s.len * 2) - 1
	unsafe {
		mut buf := &u8(malloc(len + 1))
		mut i := 0
		for c in s {
			buf[i] = c
			i++
			buf[i] = ` `
			i++
		}
		buf[len] = 0
		return buf.vstring_with_len(len)
	}
}

// words extract the words from a string.
// i.e. find all matches of the regular expression '\S+'.
pub fn words(s string) []string {
	mut buf := buffer.cap(s.len)
	mut res := []string{}
	for c in s {
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
