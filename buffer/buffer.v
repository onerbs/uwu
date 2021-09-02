module buffer

import uwu.num

type Buffer = []byte

const capacity = 0x400

// new create a Buffer with the default capacity.
pub fn new() Buffer {
	return cap(buffer.capacity)
}

// cap create a Buffer with the specified capacity.
pub fn cap(cap int) Buffer {
	return Buffer([]byte{cap: cap})
}

// value get a copy of the accumulated data as string.
pub fn (self &Buffer) value() string {
	return self.peek(0, self.len)
}

// str copy the accumulated data as string and clear the buffer.
pub fn (mut self Buffer) str() string {
	defer {
		self.trim(0)
	}
	return self.value()
}

// strip get the string representation of this item.
[direct_array_access]
pub fn (mut self Buffer) strip() string {
	if _unlikely_(self.len == 0) {
		return ''
	}
	defer {
		self.trim(0)
	}
	mut beg := 0
	mut end := self.len
	for ; beg < end && self[beg].is_space(); beg++ {}
	for ; end > beg && self[end - 1].is_space(); end-- {}
	return self.peek(beg, end - beg)
}

// peek get a copy of a portion of the data as string.
pub fn (self &Buffer) peek(beg_ int, len_ int) string {
	if _unlikely_(len_ <= 0) {
		return ''
	}
	beg := num.max(beg_, 0)
	len := num.min(self.len - beg, len_)
	unsafe {
		raw := &byte(memdup(&byte(self.data) + beg, len))
		return raw.vstring_with_len(len)
	}
}

// get_first returns the first `n` bytes from the buffer as string.
pub fn (self &Buffer) get_first(n int) string {
	if _unlikely_(n < 1) {
		return ''
	}
	len := num.min(n, self.len)
	return self.peek(0, len)
}

// get_last returns the last `n` bytes from the buffer as string.
pub fn (self &Buffer) get_last(n int) string {
	if _unlikely_(n < 1) {
		return ''
	}
	len := num.min(n, self.len)
	beg := self.len - len
	return self.peek(beg, len)
}

// cut_first get and remove the first `n` bytes from the buffer as string.
pub fn (mut self Buffer) cut_first(n int) string {
	defer {
		self.drop_first(n)
	}
	return self.get_first(n)
}

// cut_last get and remove the last `n` bytes from the buffer as string.
pub fn (mut self Buffer) cut_last(n int) string {
	defer {
		self.drop_last(n)
	}
	return self.get_last(n)
}

// drop_first discards the first `n` bytes from the buffer.
pub fn (mut self Buffer) drop_first(n int) {
	if _unlikely_(n < 1) {
		return
	}
	len := self.len - num.min(n, self.len)
	if len > 0 {
		unsafe {
			vmemmove(self.data, &byte(self.data) + n, len)
		}
	}
	self.trim(len)
}

// drop_last discards the last `n` bytes from the buffer.
pub fn (mut self Buffer) drop_last(n int) {
	if _unlikely_(n < 1) {
		return
	}
	len := self.len - num.min(n, self.len)
	self.trim(len)
}

// index returns the index of the first match of the specified substring.
pub fn (self Buffer) index(sub string) int {
	if sub.len > 0 {
		lim := self.len - sub.len + 1
		for i in 0 .. lim {
			for j := 0; self[i + j] == sub[j]; j++ {
				if j + 1 == sub.len {
					return i
				}
			}
		}
	}
	return -1
}

// last_index returns the index of the last match of the specified substring.
pub fn (self Buffer) last_index(sub string) int {
	if sub.len > 0 {
		for i := self.len - sub.len; i >= 0; i-- {
			for j := 0; self[i + j] == sub[j]; j++ {
				if j + 1 == sub.len {
					return i
				}
			}
		}
	}
	return -1
}

// contains check whether the buffer contains the specified substring or not.
pub fn (self &Buffer) contains(sub string) bool {
	return self.index(sub) >= 0
}

// write appends a string to the accumulated buffer.
[inline]
pub fn (mut self Buffer) write(str string) {
	unsafe { self.push_many(str.str, str.len) }
}

// writeln appends a string and a newline character to the accumulated buffer.
pub fn (mut self Buffer) writeln(str string) {
	self.write(str)
	self << `\n`
}
