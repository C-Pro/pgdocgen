'''Input files reading routines'''

import os

def read_file(fname):
    '''reads and returns file contents as a string'''
    with open(fname,'r') as f:
        return f.read()
    return None


def read_dir(input_dir,input_ext,func):
    '''reads all files with extension input_ext
       in a directory input_dir and apply function func
       to their contents'''
    import os
    print('Input dir: {}'.format(input_dir))
    for dirpath, dnames, fnames in os.walk(input_dir):
        for fname in fnames:
            if not dirpath.endswith(os.sep):
                dirpath = dirpath + os.sep
            print(dirpath + fname)
            if fname.endswith(input_ext):
                func(read_file(dirpath + fname))

