module ups

import uwu.str

[inline]
pub fn cannot(verb string, target string) IError {
	nam := highlight(target)
	return raise('could not ${verb} ${nam}')
}

[inline]
pub fn invalid(kind string, value string) IError {
	val := highlight(str.quote(value))
	return raise('invalid ${kind} ${val}')
}

[inline]
pub fn missing(kind string, name string) IError {
	nam := highlight(name)
	return raise('missing ${kind} ${nam}')
}

[inline]
pub fn missing_value(kind string, name string) IError {
	nam := highlight(str.quote(name))
	return raise('the ${kind} ${nam} has no value')
}

[inline]
pub fn not_enough(kind string, min int, value int) IError {
	val := highlight(value.str())
	return raise('not enough ${kind}: expecting at least ${min}, got ${val}')
}

[inline]
pub fn not_found(kind string, name string) IError {
	nam := highlight(str.brace(name, '`'))
	return raise('the ${kind} ${nam} was not found')
}

[inline]
pub fn too_many(kind string, max int, value int) IError {
	val := highlight(value.str())
	return raise('too many ${kind}: expecting less than ${max}, got ${val}')
}

[inline]
pub fn unexpected(kind string, value string) IError {
	val := highlight(str.brace(value, '`'))
	return raise('unexpected value ${val}, expecting ${kind}')
}

[inline]
pub fn unknown(kind string, value string) IError {
	val := highlight(str.quote(value))
	return raise('unknown ${kind} ${val}')
}

// raise returns an error with code `1`
[inline]
pub fn raise(msg string) IError {
	return error_with_code(msg, 1)
}

[inline]
fn highlight(s string) string {
	return '\x1b[1m${s}\x1b[0m'
}
