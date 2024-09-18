return {
    -- Format todo for python.
    s("todo", fmt("# TODO", { })),

    -- main() boiler-plate for executable scripts.
    s("main", fmt([[
        import argparse
        import sys


        def parse_args(args):
            parser = argparse.ArgumentParser()
            parser.add_argument({})
            return parser.parse_args(args)


        def main(args):
            args = parse_args(args)
            return


        if __name__ == '__main__':
            main(sys.argv[1:])
        ]], { i(1) })),

    -- Function skeleton.
    s("def", fmt([[
        def {}({}):
            return {}


        ]], { i(1, "function"), i(2), i(3, "None"), })),

    -- Markdown cell in jupynium.
    -- todo: make this specific to .ju.py files
    s("md", fmt([[
        # %% [md]
        """
        {}
        """

        ]], { i(1) })),

    -- Code cell in jupynium.
    -- todo: make this specific to .ju.py files
    s("cc", fmt([[
        # %%
        {}

        ]], { i(1) })),
}
