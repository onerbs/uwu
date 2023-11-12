module app

import uwu.cli.flag

// flag create and push a flag with value.
pub fn (mut app App) add_flag(cfg flag.Config) &flag.Flag {
  mut ref := flag.new(cfg)
  // app.validate(ref.name) or { panic(err.msg()) }
  // app.validate(ref.alias.ascii_str()) or { panic(err.msg()) }
  ref.metro = &app.metro
  app.flags << &ref
  return &ref
}

// find_flag return the flag with the specified id.
pub fn (app App) find_flag(id string) ?&flag.Flag {
  for flag in app.flags {
    if flag.matches(id) {
      return flag
    }
  }
  return none
}

fn (app App) validate(id string) ! {
  if id.len < 1 { return }
  for app_flag in app.flags {
    if app_flag.matches(id) {
      return error('the flag id "${id}" is already taken')
    }
  }
}
