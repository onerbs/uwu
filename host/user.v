module host

import os

pub const (
	user_name = os.loginname() or { '' }
	user_home = os.home_dir()
	user_data = get_config_dir()
	user_path = os.getenv('PATH').split(os.path_delimiter)
)

fn get_config_dir() string {
	bak := $if windows {
		os.getenv('APPDATA')
	} $else {
		os.join_path(host.user_home, '.config')
	}
	return os.config_dir() or { bak }
}
