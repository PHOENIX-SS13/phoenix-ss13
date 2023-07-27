#!/usr/bin/env python3

if __name__ == '__main__':
    if __package__ is None:
        import sys
        from os import path
        sys.path.append( path.dirname( path.dirname( path.abspath(__file__) ) ) )
        import frontend, dmm
    else:
        from . import frontend, dmm
    settings = frontend.read_settings()
    for fname in frontend.process(settings, "convert"):
        dmm.DMM.from_file(fname).to_file(fname, tgm = settings.tgm)
