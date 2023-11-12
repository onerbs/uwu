module token

pub enum TokenKind {
	flag
	long_flag
	equals
	colon
	other
}

pub struct Token {
pub:
	kind TokenKind   // the token kind
	lit  string // literal representation of the token
}
