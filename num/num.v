module num

// fits count how many times `n` fits on `m`.
// returns the remainder as the second value.
[inline]
pub fn fits<T>(n T, m T) (T, T) {
	mut t := 0
	mut k := m
	for k >= n {
		k -= n
		t++
	}
	return t, k
}

// max get the maximum value of the two provided.
[inline]
pub fn max<T>(a T, b T) T {
	if a > b {
		return a
	}
	return b
}

// min get the minimum value of the two provided.
[inline]
pub fn min<T>(a T, b T) T {
	if a < b {
		return a
	}
	return b
}

// max get the maximum value of the two provided.
[inline]
pub fn max_of<T>(ary []T) T {
	if ary.len == 0 {
		panic(@FN + ' called on an empty array.')
	}
	mut res := ary[0]
	for val in ary[1..] {
		if val > res {
			res = val
		}
	}
	return res
}

// min get the minimum value of the two provided.
[inline]
pub fn min_of<T>(ary []T) T {
	if ary.len == 0 {
		panic(@FN + ' called on an empty array.')
	}
	mut res := ary[0]
	for val in ary[1..] {
		if val < res {
			res = val
		}
	}
	return res
}

// strict returns n in a restricted range.
[inline]
pub fn strict<T>(n T, min T, max T) T {
	if n < min {
		return min
	}
	if n > max {
		return max
	}
	return n
}

// wrap normalize the value in the range [a-b].
[inline]
pub fn wrap<T>(n T, a T, b T) T {
	beg := min(a, b)
	end := max(a, b)
	mut len := 1
	for ; beg + (len - 1) < end; len++ {}
	mut res := n
	for ; res < beg; res += len {}
	for ; res > end; res -= len {}
	return res
}
