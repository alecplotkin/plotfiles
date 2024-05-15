return {
    s("todo", fmt("-- todo", { })),
    s("req", fmt("local {} = require('{}')", { i(1), rep(1) })),
}
