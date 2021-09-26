module uwu

import uwu.str
import uwu.scene
import term

// input_secret read input from the user.
pub fn input_secret(hint_ string) string {
	print(highlight(hint))

	scene.raw_mode()

	mut buf := []byte{cap: 0x200}
	mut skip := false
	chr := 0
	for {
		size := C.read(0, &chr, 1)
		if size > 0 {
			if skip {
				skip = chr != `~`
			} else if chr == 27 {
				skip = true
			} else if chr == 127 {
				buf.trim(buf.len - 1)
				print('\r\e[2K')
				print(hint + str.repeat(`*`, buf.len))
			} else if chr >= ` ` {
				buf << byte(chr)
				print('*')
			} else if chr == `\r` || chr == `\n` {
				break
			}
		} else if size < 0 {
			scene.normal_mode()
			println('')
			$if debug {
				eprintln('Cannot read the input')
			}
			return ''
		}
	}

	scene.normal_mode()
	println('')

	return buf.bytestr()
}
