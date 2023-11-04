import uwu

fn test_get_exe() {
	cmd := uwu.get_exe('not-a-cmd')
	out := cmd.exec() or { '' }
	assert out.len == 0
}

fn test_need_exe() {
	cmd := uwu.need_exe('v')
	out := cmd.exec('-v')!
	assert out.len > 0
}
