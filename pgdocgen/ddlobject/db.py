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
        cur.execute('''select nspname,
                              description
                        from pg_catalog.pg_namespace s
                        left join pg_catalog.pg_description d
                            on (d.objoid = s.oid)
                        where s.nspname not like 'pg\_%' and
                        s.nspname <> 'information_schema'
                        order by s.nspname''')
        schemas = cur.fetchall()
        cur.close()
        from pgdocgen.ddlobject.schema import Schema
        for (schema, comment) in [(x[0], x[1]) for x in schemas]:
            schema_obj = Schema(schema, comment, self.conn)
            self.contents.append(copy.deepcopy(schema_obj))
        self.conn.close()

    def __init__(self, db_connection_string):
        '''DB constructor'''
        self.contents = []
        self.connect(db_connection_string)
        self.read_contents()
