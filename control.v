module uwu

import uwu.log

// report print a fancy error message.
pub fn report(e IError) {
	code := e.code()
	text := e.msg().trim_space()
	if text.len > 0 {
		match code {
			0 {
				log.text(text)
			}
			else {
				log.fail(text)
			}
		}
	}
}

// catch report an error and exit with the error status code.
[inline; noreturn]
pub fn catch(e IError) {
	report(e)
	exit(e.code())
}

// die terminate the program execution with an error message.
[inline; noreturn]
pub fn die(msg string) {
	catch(error_with_code(msg, 2))
}
