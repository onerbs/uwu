module buffer

// contains check whether the buffer contains the specified slice or not.
pub fn (self Buffer) contains(s string) bool {
	return self.index(s) >= 0
}

// index returns the index of the first match of the specified slice.
pub fn (self Buffer) index(s string) int {
	if s.len > 0 {
		lim := 1 + self.len - s.len
		for i in 0 .. lim {
			for j := 0; self[i + j] == s[j]; j++ {
				if j + 1 == s.len {
					return i
				}
			}
		}
	}
	return -1
}

// last_index returns the index of the last match of the specified slice.
pub fn (self Buffer) last_index(s string) int {
	if s.len > 0 {
		for i := self.len - s.len; i >= 0; i-- {
			for j := 0; self[i + j] == s[j]; j++ {
				if j + 1 == s.len {
					return i
				}
			}
		}
	}
	return -1
}
