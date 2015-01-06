'''Input files reading routines'''


def read_file(fname):
  '''reads and returns file contents as a string'''
  with open(fname,'r') as f:
    return f.read()
  return None