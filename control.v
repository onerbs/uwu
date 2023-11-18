module uwu

import uwu.log

// report print a fancy error message.
pub fn report(e IError) int {
	code := e.code()
	text := e.msg().trim_space()
	if text.len > 0 {
		if code > 0 {
			log.fail(text.all_before_last(';'))
		} else {
			log.fail(text)
		}
	}
	return code
}

// catch report an error and exit with the error status code.
@[inline; noreturn]
pub fn catch(e IError) {
	exit(report(e))
}

// die terminate the program execution with an error message.
@[inline; noreturn]
pub fn die(msg string) {
	catch(error_with_code(msg, 0xBAD))
}
