module ups

pub fn cannot(act string, target string) ? {
	throw(cannot_operate_error(act, target)) ?
}

pub fn invalid(kind string, value string) ? {
	throw(invalid_item_error(kind, value)) ?
}

pub fn missing(kind string, name string) ? {
	throw(missing_item_error(kind, name)) ?
}

pub fn missing_value(kind string, name string) ? {
	throw(missing_value_error(kind, name)) ?
}

pub fn not_enough(kind string, min int, value int) ? {
	throw(not_enough_items_error(kind, min, value)) ?
}

pub fn not_found(kind string, name string) ? {
	throw(item_not_found_error(kind, name)) ?
}

pub fn too_many(kind string, max int, value int) ? {
	throw(too_many_items_error(kind, max, value)) ?
}

pub fn unexpected(value string, kind string) ? {
	throw(unexpected_item_error(value, kind)) ?
}

pub fn unknown(kind string, value string) ? {
	throw(unknown_item_error(kind, value)) ?
}

fn throw(err IError) ? {
	return error_with_code(err.msg, err.code)
}

// raise returns an error with code `1`
pub fn raise(msg string) ? {
	return error_with_code(msg, 1)
}
