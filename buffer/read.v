module buffer

// get_first returns the first `n` bytes from the buffer as string.
pub fn (self Buffer) get_first(n int) string {
	if n < 0 {
		return self.get_last(-n)
	}
	if n > self.len {
		return self.value()
	}
	return self.peek(0, n)
}

// get_last returns the last `n` bytes from the buffer as string.
pub fn (self Buffer) get_last(n int) string {
	if n < 0 {
		return self.get_first(-n)
	}
	if n > self.len {
		return self.value()
	}
	return self.peek(self.len - n, n)
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
@[direct_array_access]
pub fn (mut self Buffer) drop_first(n int) {
	if n < 1 {
		return
	}
	if n >= self.len {
		self.trim(0)
		return
	}
	len := self.len - n
	if len > 0 {
		unsafe {
			vmemmove(self.data, self[n], len)
		}
	}
	self.trim(len)
}

// drop_last discards the last `n` bytes from the buffer.
pub fn (mut self Buffer) drop_last(n int) {
	if n < 1 {
		return
	}
	len := self.len - n
	if len < 0 {
		self.trim(0)
	} else {
		self.trim(len)
	}
}
