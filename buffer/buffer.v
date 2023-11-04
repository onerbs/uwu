module buffer

pub type Buffer = []u8

const capacity = 0x400

// new create a Buffer with the default capacity.
[inline]
pub fn new() Buffer {
	return cap(buffer.capacity)
}

// cap create a Buffer with the specified capacity.
[inline]
pub fn cap(cap int) Buffer {
	return Buffer([]u8{cap: cap})
}

// from create a new Buffer using the data in `buf`.
[inline]
pub fn from(buf []u8) Buffer {
	return Buffer(buf)
}

// str copy the accumulated data as string and clear the buffer.
pub fn (mut self Buffer) str() string {
	defer {
		self.trim(0)
	}
	return self.value()
}

// value get a copy of the accumulated data as string.
[inline]
pub fn (self Buffer) value() string {
	return self.peek(0, self.len)
}

// peek get a copy of the specified data slice as string.
[direct_array_access]
pub fn (self Buffer) peek(beg int, n int) string {
	if self.len < 1 || n < 1 {
		return ''
	}
	if beg < 0 {
		return self.peek(self.len + beg, n)
	}
	len := if beg + n > self.len { self.len - beg } else { n }
	unsafe {
		mem := &u8(memdup_noscan(self[beg], len))
		return mem.vstring_with_len(len)
	}
}

// strip get the string representation of this item.
[direct_array_access]
pub fn (mut self Buffer) strip() string {
	if self.len < 1 {
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
