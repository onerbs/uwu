module ups

import uwu.str
import uwu.scene
import term

pub fn cannot_operate_error(act string, target string) IError {
	msg := 'cannot $act ' + high(target)
	return error_with_code(msg, 1)
}

pub fn invalid_item_error(kind string, value string) IError {
	msg := 'invalid $kind ' + high(str.quote(value))
	return error_with_code(msg, 1)
}

pub fn missing_item_error(kind string, name string) IError {
	msg := 'missing $kind ' + high(name)
	return error_with_code(msg, 1)
}

pub fn missing_value_error(kind string, name string) IError {
	msg := 'the $kind ${high(str.quote(name))} has no value'
	return error_with_code(msg, 1)
}

pub fn not_enough_items_error(kind string, min int, value int) IError {
	msg := 'not enough $kind: expecting at least $min, got ' + high(value.str())
	return error_with_code(msg, 1)
}

pub fn item_not_found_error(kind string, name string) IError {
	msg := 'the $kind ${high(str.brace(name, '`'))} was not found'
	return error_with_code(msg, 1)
}

pub fn too_many_items_error(kind string, max int, value int) IError {
	msg := 'too many $kind: expecting less than $max, got ' + high(value.str())
	return error_with_code(msg, 1)
}

pub fn unexpected_item_error(value string, kind string) IError {
	msg := 'unexpected value ${high(str.brace(value, '`'))}, expecting $kind'
	return error_with_code(msg, 1)
}

pub fn unknown_item_error(kind string, value string) IError {
	msg := 'unknown $kind ' + high(str.quote(value))
	return error_with_code(msg, 1)
}

fn high(base string) string {
	return scene.colorize_err(base, term.bold)
}
