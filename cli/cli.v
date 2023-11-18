module cli

import uwu.cli.app

@[inline]
pub fn new_app(cfg app.Config) app.App {
	return app.new(cfg)
}

@[inline]
pub fn app_author(author app.Author) app.Author {
	return author
}
