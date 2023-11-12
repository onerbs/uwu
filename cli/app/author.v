module app

pub struct Author {
	name    string [required]
	email   string
	website string
}

// author create a new Author instance.
[inline]
pub fn author(a Author) Author {
	return a
}

pub fn (a Author) str() string {
	mut buf := a.name
	if a.email.len > 0 {
		buf += ' <${a.email}>'
	}
	if a.website.len > 0 {
		buf += ' — ${a.website}'
	}
	return buf
}
