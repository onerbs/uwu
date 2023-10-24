module host

import os

pub const (
	app_path = os.executable()
	app_file = os.base(app_path)
	app_name = app_file.all_before('.')
	app_data = os.join_path(user_data, app_name)
)
