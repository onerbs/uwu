module ups

import uwu.str
import term

pub fn cannot(act string, target string) ? {
	raise('cannot $act ' + high(target)) ?
}

pub fn missing(kind string, name string) ? {
	raise('missing $kind ' + high(name)) ?
}

pub fn missing_value(kind string, name string) ? {
	val := high(str.quote(name))
	raise('the $kind $val has no value') ?
}

pub fn invalid(kind string, value string) ? {
	val := high(str.quote(value))
	raise('invalid $kind $val') ?
}

pub fn unknown(kind string, value string) ? {
	val := high(str.quote(value))
	raise('unknown $kind $val') ?
}

pub fn unexpected(value string, kind string) ? {
	val := high(str.brace(value, '`'))
	raise('unexpected value $val, expecting $kind') ?
}

pub fn too_many(kind string, max int, value int) ? {
	val := high(value.str())
	raise('too many $kind: expecting less than $max, got $val') ?
}

pub fn not_enough(kind string, min int, value int) ? {
	val := high(value.str())
	raise('not enough $kind: expecting at least $min, got $val') ?
}

// raise returns an error with code `1`
pub fn raise(msg string) ? {
	return error_with_code(msg, 1)
}

fn high(base string) string {
	return term.colorize(base, term.bold)
}
