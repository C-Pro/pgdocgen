import unittest
import pgdocgen.parser


class ParserTest (unittest.TestCase):
    '''Parser test case class'''

    def test_init(self):
        j = pgdocgen.parser.JDOC('shm', 'tab', '###')
        self.assertEqual(j.schema_name, 'shm')
        self.assertEqual(j.object_name, 'tab')
        self.assertEqual(j.comment, '###')

    def test_add_param(self):
        j = pgdocgen.parser.JDOC('shm', 'tab', '###')
        j.add_param('param_name', 'param_desc')
        self.assertEqual(j.params,
                         [('param_name',
                           'param_desc')])

    def test_basic_jdoc(self):
        text = '''
/**Test comment
*@function shm.bebebe
*@param param
*@returns return
*/'''
        ret = '''##############
function shm.bebebe
Test comment
param
returns: return'''
        p = pgdocgen.parser.Parser()
        self.assertEqual(str(p.parse(text)["shm.bebebe"]), ret)

    def test_noschema_jdoc(self):
        text = '''
/**Test comment
*@function bebebe
*@param param
*@returns return
*/'''
        ret = '''##############
function public.bebebe
Test comment
param
returns: return'''
        p = pgdocgen.parser.Parser()
        self.assertEqual(str(p.parse(text)["public.bebebe"]), ret)

    def test_double_jdoc(self):
        text = '''
/**Test comment1
*@procedure shm.bebebe
*@param param1
*@param param2
*@returns return
*/
function shm.bebebe
BLAH BLAH BLAH
/* EMPTY COMMENT */

/**Test comment2
*@trigger shm.bebebe
*@returns return
*/

'''
        ret1 = '''##############
procedure shm.bebebe
Test comment1
param1
param2
returns: return'''
        ret2 = '''##############
trigger shm.bebebe
Test comment2
returns: return'''
        p = pgdocgen.parser.Parser()
        #self.assertEqual(str(p.parse(text)["shm.bebebe"]), ret1)
        self.assertEqual(str(p.parse(text)["shm.bebebe"]), ret2)

if __name__ == '__main__':
    unittest.main()
