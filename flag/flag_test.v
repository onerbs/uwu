import uwu.flag

fn test_got() {
	mut args := ['some', '--dir', 'argument', '-f']
	is_d := flag.got(mut args, '-d', '--dir')
	is_f := flag.got(mut args, '-f', '--file')
	is_h := flag.got(mut args, '-h', '--help')
	assert is_d == true
	assert is_f == true
	assert is_h == false
	assert args == ['some', 'argument']
}

fn test_get() {
	mut args := ['some', '--dir', 'ahoy', 'argument', '-f']

	assert 'ahoy' == flag.get(mut args, '-d', '--dir') or { 'fall' }
	assert args == ['some', 'argument', '-f']

	assert 'fall' == flag.get(mut args, '-f', '--file') or { 'fall' }
	assert args == ['some', 'argument', '-f']

	assert flag.got(mut args, '-f', '--file')
	assert args == ['some', 'argument']

	assert !flag.got(mut args, '-s', '--some')
	assert args == ['some', 'argument']
}

fn test_get_all() {
	mut args := ['some', '--dir', 'ahoy', 'argument']

	assert ['ahoy', 'argument'] == flag.get_all(mut args, '-d', '--dir') or { ['fall'] }
	assert args == ['some']
}

fn test_should_read_stdin() {
	assert flag.should_read_stdin(['some', '-'])
	assert !flag.should_read_stdin(['some', '-', '3'])
}
