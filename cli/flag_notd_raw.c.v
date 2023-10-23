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
		buf.write(self.brief)
	}
	return buf.str()
}
