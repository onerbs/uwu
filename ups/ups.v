module ups

[inline]
pub fn cannot(act string, target string) ? {
	raise('cannot $act $target') ?
}

[inline]
pub fn missing(kind string, name string) ? {
	raise('missing $kind $name') ?
}

[inline]
pub fn missing_value(kind string, name string) ? {
	raise('the $kind "$name" has no value') ?
}

[inline]
pub fn unknown(kind string, value string) ? {
	raise('unknown $kind $value') ?
}

[inline]
pub fn unexpected(value string, kind string) ? {
    raise('unexpected value `$value`, expecting $kind') ?
}

[inline]
pub fn too_many(kind string, max int, val int) ? {
	raise('too many $kind: expecting less than $max, got $val') ?
}

[inline]
pub fn not_enough(kind string, min int, val int) ? {
	raise('not enough $kind: expecting at least $min, got $val') ?
}

pub fn raise(msg string) ? {
    return error_with_code(msg, 1)
}
