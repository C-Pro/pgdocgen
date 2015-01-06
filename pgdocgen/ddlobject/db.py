'''DB description module'''

import psycopg2
from ddlobject.ddlobject import DDLObject

class DB(DDLObject):
  '''DB schema class'''
  
  conn = None
  
  def connect(self,db_connection_string):
    '''Make db connection'''
    self.conn = psycopg2.connect(db_connection_string)
  
  def __init__(self,db_connection_string):
    '''DB constructor'''
    self.connect(db_connection_string)