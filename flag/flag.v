module flag

pub fn got(mut args []string, flags ...string) bool {
	for f in flags {
		if f in args {
			args.delete(args.index(f))
			return true
		}
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
		if index < 0 { continue }
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
