'''DB description module'''

import copy
import psycopg2
from pgdocgen.ddlobject.ddlobject import DDLObject


class DB(DDLObject):
    '''DB schema class'''
    conn = None
    contents = []

    def connect(self, db_connection_string):
        '''Make db connection'''
        self.conn = psycopg2.connect(db_connection_string)

    def read_contents(self):
        '''Read all schemas in database'''
        cur = self.conn.cursor()
        cur.execute('''select schema_name
                     from information_schema.schemata''')
        schemas = cur.fetchall()
        cur.close()
        from pgdocgen.ddlobject.schema import Schema
        for schema in [x[0] for x in schemas]:
            schema_obj = Schema(schema, self.conn)
            self.contents.append(copy.deepcopy(schema_obj))
        self.conn.close()

    def __init__(self, db_connection_string):
        '''DB constructor'''
        self.connect(db_connection_string)
        self.read_contents()
