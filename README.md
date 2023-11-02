# uwu
some utility functions

| read the docs in every module folder

`get_args() []string`
`need_args(n int) ![]string`

`fn report(err IError)` — print the error message to the standard error.
`fn catch(err IError)` — print the error message and terminate the program execution with the `err` error code.
`die(msg string)` — print an error message and terminate the program execution with code: 2

| Shortcut functions using `uwu.stdin`
`get_bytes() []u8`
`get_text() string`
`get_lines() []string`

### File API
`open(path string) File`

`File.read_bytes() []u8`
`File.read_text() string`
`File.read_lines() []string`

`File.reopen() File`
`File.rewind()`
`File.close()`

### Command API
`Command.new(name string) Command`
`Command.need(name string) Command`

`Command.call(args ...string) !string`

`Command.sub(args string) Command`



