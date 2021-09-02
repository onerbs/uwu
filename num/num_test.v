import uwu.num

fn test_fits() {
	mut a, mut b := num.fits(5, 10)
	assert a == 2
	assert b == 0

	a, b = num.fits(5, 8)
	assert a == 1
	assert b == 3
}

fn test_mm_int() {
	assert num.min(0, 4) == 0
	assert num.min(4, 6) == 4
	assert num.min(6, 2) == 2

	assert num.max(0, 4) == 4
	assert num.max(4, 6) == 6
	assert num.max(6, 2) == 6
}

fn test_mm_of_int() {
	assert num.min_of([0, 4]) == 0
	assert num.min_of([4, 6]) == 4
	assert num.min_of([6, 2]) == 2

	assert num.max_of([0, 4]) == 4
	assert num.max_of([4, 6]) == 6
	assert num.max_of([6, 2]) == 6
}

fn test_mm_float() {
	assert num.min(0.5, 4.3) == 0.5
	assert num.min(4.5, 6.3) == 4.5
	assert num.min(6.5, 2.3) == 2.3

	assert num.max(0.5, 4.3) == 4.3
	assert num.max(4.5, 6.3) == 6.3
	assert num.max(6.5, 2.3) == 6.5
}

fn test_mm_of_float() {
	assert num.min_of([0.5, 4.3]) == 0.5
	assert num.min_of([4.5, 6.3]) == 4.5
	assert num.min_of([6.5, 2.3]) == 2.3

	assert num.max_of([0.5, 4.3]) == 4.3
	assert num.max_of([4.5, 6.3]) == 6.3
	assert num.max_of([6.5, 2.3]) == 6.5
}

fn test_strict() {
	assert num.strict(4, 0, 9) == 4
	assert num.strict(0, 4, 9) == 4
	assert num.strict(9, 0, 4) == 4
}

fn test_wrap() {
	assert num.wrap(8, 2, 7) == 2
	assert num.wrap(15, 2, 7) == 3
	assert num.wrap(19, 2, 7) == 7

	assert num.wrap(2, -3, 1) == -3
	assert num.wrap(4, -3, 1) == -1
	assert num.wrap(6, -3, 1) == 1
	assert num.wrap(7, -3, 1) == -3
	assert num.wrap(11, -3, 1) == 1

	assert num.wrap(-5, 0, 3) == 3
	assert num.wrap(-3, 0, 3) == 1
	assert num.wrap(4, 0, 3) == 0
	assert num.wrap(7, 0, 3) == 3
	assert num.wrap(8, 0, 3) == 0
	assert num.wrap(11, 0, 3) == 3
}
