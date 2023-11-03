module token

pub struct Token {
pub:
	kind Kind   // the token number/enum; for quick comparisons
	lit  string // literal representation of the token
	pos  int    // the position of the token in scanner text
	len  int    // length of the literal
	ix   int    // the index of the token
}

pub enum Kind {
	flag
	long_flag
	equals
	colon
	other
}
