return {
    s("todo", fmt("# TODO", { })),
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
    s("def", fmt([[
        def {}({}):
            return {}


        ]], { i(1, "function"), i(2), i(3, "None"), })),
}
