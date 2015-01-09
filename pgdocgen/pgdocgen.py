'''pgdocgen starting point'''

if __name__=='__main__':
  from files import read_file
  s = read_file('big.sql')
  #from ddlobject.db import DB
  #db = DB('dbname=hr user=hr port=5432 password=hr host=127.0.0.1')
  from parser import Parser
  p = Parser()
  r = p.parse(s)
  from output import HtmlGenerator 
  g = HtmlGenerator()
  g.write_files(r,'/tmp')
