module num

// fits count how many times `n` fits on `m`.
// returns the remainder as the second value.
pub fn fits[T](n T, m T) (T, T) {
	mut t := 0
	mut k := m
	for k >= n {
		k -= n
		t++
	}
	return t, k
}

// max get the maximum value of the input.
@[inline]
pub fn max[T](a T, b T) T {
	return if a > b { a } else { b }
}

// min get the minimum value of the input.
@[inline]
pub fn min[T](a T, b T) T {
	return if a < b { a } else { b }
}

// max_of get the maximum value of the input array.
@[direct_array_access]
pub fn max_of[T](ary []T) T {
	if ary.len < 1 {
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

// min_of get the minimum value of the input array.
@[direct_array_access]
pub fn min_of[T](ary []T) T {
	if ary.len < 1 {
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

// within returns the value in the range [a-b].
@[inline]
pub fn within[T](n T, min T, max T) T {
	if n < min {
		return min
	}
	if n > max {
		return max
	}
	return n
}

// wrap normalize the value in the range [a-b].
pub fn wrap[T](n T, a T, b T) T {
	mut res := n
	mut len := 1
	beg := min(a, b)
	end := max(a, b)
	for ; beg + (len - 1) < end; len++ {}
	for ; res < beg; res += len {}
	for ; res > end; res -= len {}
	return res
}
