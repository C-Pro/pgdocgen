import unittest
import pgdocgen.readddl
import pgdocgen.ddlobject.db


class DDLTest (unittest.TestCase):
    '''DDL extractor test case class'''

    def test_init(self):
        #TODO: get connstr from config
        connstr = 'dbname=test_pgdocgen user=test_pgdocgen \
        port=5432 password=aoijrm39R host=127.0.0.1'
        db = pgdocgen.ddlobject.db.DB(connstr)
        self.assertEqual(len(db.contents), 3)
        self.assertEqual(db.contents[0].object_type, 'schema');
        schema_set = set([x.object_name for x in db.contents])
        self.assertEqual(schema_set, {'public', 's1', 's2'})
        self.assertEqual(len(db.contents[1].contents), 1)
        self.assertEqual(db.contents[1].contents[0].object_name,
                         't1')
        self.assertEqual(db.contents[1].contents[0].object_type,
                         'table')
        self.assertEqual(len(db.contents[2].contents), 1)
        self.assertEqual(db.contents[2].contents[0].object_name,
                         't2')


if __name__ == '__main__':
    unittest.main()
