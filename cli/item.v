module cli

[heap]
pub struct Item {
pub:
	// brief string
	name        string
	is_optional bool = true
mut:
	value string
}

pub fn (self Item) value() string {
	return self.value.clone()
}

pub fn (self Item) str() string {
	if self.is_optional {
		return '[<${self.name}>]'
	}
	return '<${self.name}>'
}
