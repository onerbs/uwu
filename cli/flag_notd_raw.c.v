module cli

import uwu.buffer

pub fn (self &Flag) str() string {
	mut buf := buffer.cap(0x20)
	buf.write(self.armor())
	if self.brief.len > 0 {
		metro := *self.metro - buf.len
		for _ in 0 .. metro + 4 {
			buf << ` `
		}
		// todo:
		// buf.write(self.brief)
		// buf.replace_once('@item', self.item)
		mut brief := self.brief
		if self.item.len > 0 {
			brief = brief.replace_once('@item', self.item)
		}
		buf.write(brief)
	}
	return buf.str()
}

pub fn (self &Flag) armor() string {
	mut buf := buffer.cap(0x20)
	if self.name.len > 0 {
		buf << `-`
		buf << `-`
		buf.write(self.name)
	}
	if self.alias > 0 {
		if buf.len > 0 {
			buf << `,`
			buf << ` `
		}
		if self.alias != `-` {
			buf << `-`
		}
		buf << byte(self.alias)
	}
	if self.item.len > 0 {
		buf << ` `
		buf << `<`
		buf.write(self.item)
		buf << `>`
	}
	return buf.str()
}
