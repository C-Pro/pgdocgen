'''Schema description module'''
import copy
from pgdocgen.ddlobject.ddlobject import DDLObject
from pgdocgen.utils import get_logger


class Schema(DDLObject):
    '''SQL schema class'''

    contents = []

    def read_contents(self, name, conn):
        '''Read schema tables'''
        sql = '''select c.relname,
                        d.description,
                        case c.relkind
                          when 'r' then 'table'
                          when 'v' then 'view'
                          when 'm' then 'materialized view'
                          when 'f' then 'foreign table'
                        end as table_type
                  from pg_catalog.pg_class c
                  join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                  left join pg_catalog.pg_description d on (d.objoid = c.oid)
                where c.relkind in ('r','v','m','f') and
                      n.nspname = %s and
                      n.nspname not like 'pg\_%%' and
                      n.nspname not in ('information_schema') and
                      coalesce(d.objsubid,0) = 0
             order by c.relname'''
        log = get_logger()
        cur = conn.cursor()
        cur.execute(sql, [name])
        tables = cur.fetchall()
        from pgdocgen.ddlobject.table import Table
        for table in tables:
            table_obj = Table(name, table[0], table[1], table[2], conn)
            log.debug('{}: {}'.format(table[0], table[1]))
            self.contents.append(copy.deepcopy(table_obj))
        cur.close()

    def __init__(self, name, comment, conn):
        '''Schema object constructor'''
        self.contents = []
        self.object_type = 'schema'
        self.comment = comment
        self.object_name = name
        self.read_contents(name, conn)
