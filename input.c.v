module uwu

import uwu.str
import uwu.buffer
import term
import os

#flag -I@VMODROOT

#include "input.h"

fn C.enable_raw_mode()

fn C.disable_raw_mode()

// input read input from the user.
pub fn input(hint_ string) string {
	hint := get_hint(hint_)
	res := os.input(hint)
	return res
}

// input_secret read input from the user.
pub fn input_secret(hint_ string) string {
	hint := get_hint(hint_)
	print(hint)

	C.enable_raw_mode()

	mut buf := buffer.new()
	mut skip := false
	for {
		mut c := 0
		size := C.read(0, &c, 1)
		if size > 0 {
			if skip {
				skip = c != `~`
			} else if c == 27 {
				skip = true
			} else if c == 127 {
				buf.drop_last(1)
				print('\r\e[2K')
				print(hint + str.repeat(`*`, buf.len))
			} else if c >= ` ` {
				buf << byte(c)
				print('*')
			} else if c == `\r` || c == `\n` {
				break
			}
		} else if size < 0 {
			$if debug {
				eprintln('Cannot read the input')
			}
			return ''
		}
	}

	C.disable_raw_mode()

	println('')
	return buf.bytestr()
}

fn get_hint(hint_ string) string {
	hint := hint_.trim_space().trim_right(':')
	return term.colorize(hint, term.bold) + ': '
}
