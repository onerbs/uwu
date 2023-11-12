module flag

import uwu.buffer

pub fn (flag Flag) armor() string {
	mut buf := buffer.cap(0x20)
	if flag.name.len > 0 {
		buf << `-`
		buf << `-`
		buf.write(flag.name)
	}
	if flag.alias > 0 {
		if buf.len > 0 {
			buf << `,`
			buf << ` `
		}
		if flag.alias != `-` {
			buf << `-`
		}
		buf << u8(flag.alias)
	}
	if flag.item.len > 0 {
		buf << ` `
		buf << `<`
		buf.write(flag.item)
		buf << `>`
	}
	return buf.str()
}

pub fn (flag Flag) str() string {
	mut buf := buffer.cap(0x20)
	buf.write(flag.armor())
	if flag.brief.len > 0 {
		metro := *flag.metro - buf.len
		for _ in 0 .. metro + 4 {
			buf << ` `
		}
		buf.write(flag.brief)
	}
	return buf.str()
}
