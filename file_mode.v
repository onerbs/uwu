module uwu

enum FileMode {
	raw
	read
	write
	append
}

fn (m FileMode) str() string {
	return match m {
		.raw { 'b' }
		.read { 'r' }
		.write { 'w' }
		.append { 'w+' }
	}
}
