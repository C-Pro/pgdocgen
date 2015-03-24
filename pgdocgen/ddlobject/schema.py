'''Schema description module'''
import copy
from pgdocgen.ddlobject.ddlobject import DDLObject


class Schema(DDLObject):
    '''SQL schema class'''

    contents = []

    def read_contents(self, name, conn):
        '''Read table columns'''
        sql = '''select c.relname,
                        d.description
                  from pg_catalog.pg_class c
                  join pg_catalog.pg_tables t on c.relname = t.tablename
                  join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                  left join pg_catalog.pg_description d on (d.objoid = c.oid)
                where c.relkind = 'r' and
                      n.nspname = %s and
                      n.nspname not like 'pg\_%%' and
                      n.nspname not in ('information_schema') and
                      d.objsubid = 0
             order by c.relname'''
        cur = conn.cursor()
        cur.execute(sql, [name])
        tables = cur.fetchall()
        from pgdocgen.ddlobject.table import Table
        for table in tables:
            table_obj = Table(name, table[0], table[1], conn)
            print('{}: {}'.format(table[0], table[1]))
            self.contents.append(copy.deepcopy(table_obj))
        cur.close()

    def __init__(self, name, conn):
        '''Schema object constructor'''
        self.read_contents(name, conn)
        self.object_name = name
