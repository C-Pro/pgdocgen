'''Table description module'''
import copy
from pgdocgen.ddlobject.ddlobject import DDLObject
from pgdocgen.utils import get_logger


class Table(DDLObject):
    '''SQL Table class'''

    contents = []

    def read_contents(self, schema, name, conn):
        '''Read table columns'''
        sql = '''
with schemas as
(select n.oid,
        n.nspname as name
  from pg_catalog.pg_namespace n),
tables as
(select c.oid,
        c.relnamespace as schema_oid,
        c.relname as name
 from pg_catalog.pg_class c
 where c.relkind in ('r','v','m','f'))
select a.attname,
       ty.typname,
       d.description
 from
    schemas s
    join tables t on (s.oid = t.schema_oid)
    join pg_catalog.pg_attribute a on (a.attrelid = t.oid)
    join pg_catalog.pg_type ty on (ty.oid = a.atttypid)
    left join pg_catalog.pg_description d on
    (d.objoid = a.attrelid and d.objsubid = coalesce(a.attnum,d.objsubid))
where s.name = %s and
      t.name = %s and
      coalesce(a.attnum,1) > 0
order by s.name,t.name,a.attnum'''
        log = get_logger()
        cur = conn.cursor()
        cur.execute(sql, [schema, name])
        columns = cur.fetchall()
        for column in columns:
            column_dict = {'name': column[0],
                           'type': column[1],
                           'comment': column[2]}
            log.debug('{} {}: {}'.format(column[0], column[1], column[2]))
            self.contents.append(copy.deepcopy(column_dict))
        cur.close()

    def __init__(self, schema_name, name, comment, table_type, conn):
        '''Table object constructor'''
        self.contents = []
        self.object_name = name
        self.object_type = table_type
        self.comment = comment
        self.schema_name = schema_name
        self.read_contents(schema_name, name, conn)
