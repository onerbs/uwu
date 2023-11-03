module cli

pub struct Author {
	name    string [required]
	email   string
	website string
}

pub fn (self Author) str() string {
	mut res := self.name
	if self.email.len > 0 {
		res = '${res} <${self.email}>'
	}
	if self.website.len > 0 {
		res = '${res} — ${self.website}'
	}
	return res
}
