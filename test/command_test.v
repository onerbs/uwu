import uwu { Command }

fn test_command() {
	cmd := Command.need('v')
	out := cmd.call('-v')!
	assert out.len > 0
}
