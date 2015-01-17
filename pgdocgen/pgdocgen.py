#!/usr/bin/env python
'''pgdocgen starting point'''

def process_file(jdoc):
    '''Function to be called on each source file.
       It parses file and generates JDOC objects'''
    def process_int(s):
        '''internal process_file without jdoc parameter'''
        from parser import Parser
        p = Parser()
        r = p.parse(s)
        global jdoc
        jdoc = jdoc + r
    return process_int

if __name__=='__main__':
    from getopt import getopt
    import sys
    optlist, args = getopt(sys.argv,'x',[])
    input_dir = args[1]
    input_ext = args[2]
    output_dir = args[3]
    jdoc = []
    from files import read_dir
    read_dir(input_dir,input_ext,process_file(jdoc))

    #from ddlobject.db import DB
    #db = DB('dbname=hr user=hr port=5432 password=hr host=127.0.0.1')

    from output import HtmlGenerator
    g = HtmlGenerator()
    g.write_files(jdoc,output_dir)

