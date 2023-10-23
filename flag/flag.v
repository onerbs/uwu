module flag

pub fn got(mut args []string, flags ...string) bool {
	for f in flags {
		ix := args.index(f)
		if ix < 0 {
			continue
		}
		args.delete(ix)
		return true
	}
	return false
}

[direct_array_access]
pub fn get(mut args []string, flags ...string) ?string {
	for f in flags {
		ix := args.index(f)
		if ix < 0 {
			continue
		}
		res := (*args)[ix + 1] or { continue }
		args.delete(ix)
		args.delete(ix)
		return res
	}
	return none
}

pub fn get_all(mut args []string, flags ...string) ?[]string {
	for f in flags {
		index := args.index(f)
		if index < 0 {
			continue
		}
		if index + 1 == args.len {
			args.trim(index)
			break
		}
		value := (*args)[index + 1..]
		args.trim(index)
		return value
	}
	return none
}

// should_read_stdin will return `true` if the last item in `args` is a dash.
[inline; direct_array_access]
pub fn should_read_stdin(args []string) bool {
	return args.len > 0 && args[args.len - 1] == '-'
}
