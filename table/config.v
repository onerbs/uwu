module table

[noinit]
pub struct TableConfig {
	rd  string = '\n' // The row delimiter
	cd  string = ':' // The cell delimiter
	gap u8     = 2
}

// config create a `Table` with the specified configuration.
[inline]
pub fn config(self TableConfig) TableConfig {
	return self
}

// source create a `Table` from a string.
[inline]
pub fn (self TableConfig) source(src string) Table {
	return self.lines(src.split(self.rd))
}

// lines create a `Table` from a list of lines.
[inline]
pub fn (self TableConfig) lines(src []string) Table {
	return self.matrix(src.map(it.split(self.cd)))
}

// matrix create a `Table` from a string matrix.
[direct_array_access]
pub fn (self TableConfig) matrix(src [][]string) Table {
	mut metro := []int{}
	data := src.map(self.parse_row(it, mut metro))
	for end := metro.len; end >= 0; end-- {
		if metro[end - 1] > 0 {
			metro.trim(end)
			break
		}
	}
	return Table{data, metro, self.gap}
}

// parse_row parse the raw row updating the metro data.
[direct_array_access]
fn (self TableConfig) parse_row(row []string, mut metro []int) []string {
	mut res := []string{}
	mut len := 0
	for ix in 0 .. row.len {
		cell := row[ix].trim_space()
		if ix == metro.len {
			metro << cell.len
		} else if cell.len > metro[ix] {
			metro[ix] = cell.len
		}
		if cell.len > 0 {
			len = ix + 1
		}
		res << cell
	}
	res.trim(len)
	return res
}
