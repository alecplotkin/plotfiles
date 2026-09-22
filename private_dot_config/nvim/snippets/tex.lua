return {
    -- Format todo for LaTeX.
    s("todo", fmt("% TODO", { })),

    -- Environment skeleton.
    s("env", {
        t("\\begin{"), i(1), t("}"),
        t({"", "\t"}), i(2),
        t({"", "\\end{"}), f(function(args) return args[1][1] end, {1}), t("}"),
    }),
}
