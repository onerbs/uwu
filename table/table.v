module table

[noinit]
pub struct Table {
	data  [][]string
	metro []int
	gap   u8
}

// source create a Table from a string
[inline]
pub fn source(src string) Table {
	return TableConfig{}.source(src)
}

// lines create a Table from a list of lines
[inline]
pub fn lines(src []string) Table {
	return TableConfig{}.lines(src)
}

// matrix create a Table from a string matrix
[inline]
pub fn matrix(src [][]string) Table {
	return TableConfig{}.matrix(src)
}

// str returns a string representation of this `Table`
[inline]
pub fn (self Table) str() string {
	return self.lines().join_lines()
}

// lines returns the lines on this Table
[direct_array_access]
pub fn (self Table) lines() []string {
	mut buf := []u8{}
	mut res := []string{}
	mut pos := 0
	mut lim := 0
	for row in self.data {
		lim = row.len - 1
		pos = 0
		for cell in row {
			for byt in cell {
				buf << u8(byt)
			}
			if pos < lim {
				dif := self.metro[pos] - cell.len
				gap := self.gap + dif
				for _ in 0 .. gap {
					buf << ` `
				}
			}
			pos++
		}
		mut val := ''
		if buf.len > 0 {
			unsafe {
				val = buf[0].vstring_with_len(buf.len)
				buf.trim(0)
			}
		}
		res << val
	}
	return res
}

// cells returns the cells on this Table
[direct_array_access]
pub fn (self Table) cells() [][]string {
	mut res := self.data.clone()
	for ix in 0 .. res.len {
		for res[ix].len < self.metro.len {
			res[ix] << ''
		}
	}
	return res
}
