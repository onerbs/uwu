module uwu

// report print a fancy error message.
pub fn report(err IError) {
	code := err.code()
	text := err.msg()
	if text.len > 0 {
		match code {
			0 {
				eprintln(text)
			}
			else {
				eprintln(' Error: ${text}')
			}
		}
	}
}

// catch report an error and exit with the error status code.
[inline; noreturn]
pub fn catch(err IError) {
	report(err)
	exit(err.code())
}

// die terminate the program execution with an error message.
[inline; noreturn]
pub fn die(err string) {
	catch(error_with_code(err, 2))
}
