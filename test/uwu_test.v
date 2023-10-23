import uwu

fn test_get_exe_name() {
	$if windows {
		assert uwu.get_exe_name('uwu') == 'uwu.exe'
	} $else {
		assert uwu.get_exe_name('uwu.exe') == 'uwu'
	}
}
