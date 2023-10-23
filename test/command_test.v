import uwu

fn test_command() {
	cmd := uwu.need_command('v')
	out := cmd.call('-v') or { '' }
	assert out.len > 0
}
