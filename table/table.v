module table

struct Table {
	data  [][]string
	metro []int
	gap   byte
}

// source create a Table from a string
pub fn source(src string) Table {
	return TableConfig{}.source(src)
}

// lines create a Table from a list of lines
pub fn lines(src []string) Table {
	return TableConfig{}.lines(src)
}

// matrix create a Table from a string matrix
pub fn matrix(src [][]string) Table {
	return TableConfig{}.matrix(src)
}

// str returns a string representation of this `Table`
pub fn (self Table) str() string {
	return self.lines().join_lines()
}

// lines returns the lines on this Table
[direct_array_access]
pub fn (self Table) lines() []string {
	mut buf := []byte{cap: 25}
	mut res := []string{}
	mut pos := 0
	mut lim := 0
	for row in self.data {
		lim = row.len - 1
		pos = 0
		for cell in row {
			unsafe { buf.push_many(cell.str, cell.len) }
			if pos < lim {
				dif := self.metro[pos] - cell.len
				for _ in 0 .. self.gap + dif {
					buf << ` `
				}
			}
			pos++
		}
		res << buf.bytestr()
		buf.trim(0)
	}
	return res
}

// cells returns the cells on this Table
pub fn (self Table) cells() [][]string {
	mut res := self.data.map(it.clone())
	len := self.metro.len
	for ix in 0 .. res.len {
		for res[ix].len < len {
			res[ix] << ''
		}
	}
	return res
}
