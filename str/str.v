module str

// Unicode codepoint of the «space» (` `) character.
const byt_space = u8(` `)

// Unicode codepoint of the «newline» (`\n`) character.
const byt_newline = u8(`\n`)

// brace will surround the base string in a brace pair or
// place a bracer at the end and another at the beginning
// of the base string.
[inline]
pub fn brace(s string, left string) string {
	right := str.str_pairs[left] or { left }
	return '${left}${s}${right}'
}

// brace will surround the base string into.
[inline]
pub fn brace_mirror(s string, left string) string {
	return '${left}${s}${mirror(left)}'
}

// digits extract the numeric characters from a string.
[direct_array_access]
pub fn digits(s string) string {
	mut buf := []u8{}
	for byt in s {
		if byt.is_digit() {
			buf << byt
		}
	}
	if buf.len > 0 {
		return buf.bytestr()
	}
	return ''
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
		vmemset(buf + s.len, str.byt_space, gap)
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
		vmemset(buf, str.byt_space, gap)
		vmemcpy(buf + gap, s.str, s.len)
		return buf.vstring_with_len(size)
	}
}

// key_value extract a key-value pair from a string.
[inline]
pub fn key_value(s string, delim string) (string, string) {
	if s.contains(delim) {
		key := s.all_before(delim)
		val := s.all_after(delim)
		return key, val
	}
	return s, ''
}

// lines extract the lines from a string, trimming white spaces
// and skipping empty lines.
[direct_array_access]
pub fn lines(s string) []string {
	mut buf := []u8{}
	mut res := []string{}
	for byt in s {
		match byt {
			`\r` {}
			str.byt_newline {
				if buf.len > 0 {
					res << buf.bytestr()
					buf.trim(0)
				}
			}
			else {
				buf << byt
			}
		}
	}
	if buf.len > 0 {
		res << buf.bytestr()
	}
	return res
}

// mirror will reverse the base string, also mirroring any
// supported character.
[direct_array_access]
pub fn mirror(s string) string {
	mut buf := []u8{}
	for i := s.len - 1; i >= 0; i-- {
		byt := s[i]
		chr := str.byt_pairs[byt] or { byt }
		buf << chr
	}
	if buf.len > 0 {
		return buf.bytestr()
	}
	return ''
}

// quote will surround the provided string in double quotes.
[inline]
pub fn quote(s string) string {
	return brace(s, '"')
}

// single_quote will surround the provided string in single quotes.
[inline]
pub fn single_quote(s string) string {
	return brace(s, "'")
}

// safe_quote will surround the provided string in double quotes
// if it contains spaces, escaping the already existing double quotes.
[inline]
pub fn safe_quote(s string) string {
	if s.contains(' ') && !is_quoted(s) {
		if s.contains('"') {
			return single_quote(s)
		}
		return quote(s)
	}
	return s
}

[inline]
pub fn unquote(s string) string {
	val := s.trim_space()
	if is_quoted(val) {
		tmp := rune(val[0])
		return s.replace('${tmp}', '')
	}
	return s
}

// the quotation characters.
const quote_chars = [`'`, `"`, `\``]

// is_quoted tells whether the provided string is surrounded by quotes.
[direct_array_access; inline]
pub fn is_quoted(s string) bool {
	val := s.trim_space()
	return val.len > 1 && val[0] == val[val.len - 1] && str.quote_chars.contains(val[0])
}

// repeat create a string with len n only containing the
// character c.
pub fn repeat(c u8, n int) string {
	if c < 1 || n < 1 {
		return ''
	}
	unsafe {
		buf := &u8(malloc(n + 1))
		vmemset(buf, c, n)
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
			vmemcpy(buf + ofs, s.str, s.len)
			ofs += s.len
		}
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
			buf[i] = str.byt_space
			i++
		}
		return buf.vstring_with_len(len)
	}
}

// words extract the words from a string.
// i.e. find all matches of the regular expression '\S+'.
pub fn words(s string) []string {
	mut buf := []u8{}
	mut res := []string{}
	for byt in s {
		if byt.is_space() {
			if buf.len > 0 {
				res << buf.bytestr()
				buf.trim(0)
			}
		} else {
			buf << byt
		}
	}
	if buf.len > 0 {
		res << buf.bytestr()
	}
	return res
}

const (
	str_pairs = {
		'(': ')'
		'<': '>'
		'[': ']'
		'{': '}'
		'¡': '!'
		'¿': '?'
	}
	byt_pairs = {
		`(`: `)`
		`<`: `>`
		`[`: `]`
		`{`: `}`
		`¡`: `!`
		`¿`: `?`
	}
)
