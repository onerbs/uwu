module host

import os

pub const (
	user_name = os.loginname() or { '' }
	user_home = os.home_dir()
	// todo: [uwu.this.user.data] use XDG for non-windows.
	user_data = $if windows {
		os.getenv('APPDATA')
	} $else {
		os.join_path(user_home, '.config')
	}
	user_path = os.getenv('PATH').split(os.path_delimiter)
)
