import uwu

fn test_exec() {
	mut out := uwu.exec('v', '-v')!
	assert out.len > 0

	out = uwu.exec('id', 'uwu') or { '' }
	assert out.len == 0
}

fn test_call() {
	mut res := uwu.call('git', 'branch', '--show-current')
	assert res == 0

	res = uwu.call('touch', '/etc/uwu')
	assert res != 0
}

fn test_get_exe_name() {
	$if windows {
		assert uwu.get_exe_name('uwu') == 'uwu.exe'
	} $else {
		assert uwu.get_exe_name('uwu.exe') == 'uwu'
	}
}
