'''naive JDOC subset parser module'''
import copy
import re


class JDOC(object):
    '''Parsed jdoc object'''
    schema_name = ''
    object_name = ''
    object_type = ''
    comment = ''
    params = []
    returns = ''

    def __init__(self, schema_name, object_name, comment):
        '''Constructor of jdoc class'''
        self.schema_name = schema_name
        self.object_name = object_name
        self.comment = comment
        self.params = []

    def add_param(self, param_name, param_desc):
        '''add param value to jdoc'''
        self.params.append((param_name, param_desc))

    def __str__(self):
        '''string representation for debugging'''
        s = '##############\n{} {}.{}\n{}\n'.format(self.object_type,
                                                    self.schema_name,
                                                    self.object_name,
                                                    self.comment)
        for param in self.params:
            s = s + param[1] + '\n'
        if self.returns != '':
            s = s + 'returns: {}'.format(self.returns)
        return s


class Parser(object):
    '''naive JDOC subset parser class'''

    def __init__(self):
        '''Compiles regular expressions'''
        self.RE_START_COMMENT = re.compile(r'^[\s]*\/\*\*(.*)$')
        self.RE_COMMENT_BODY = re.compile(r'^[\s]*\*[\s]*([^@/]{1}.*)$')
        self.RE_END_COMMENT = re.compile(r'(.*)\*/')
        self.RE_PARAM = re.compile(r'^[\s]*\*[\s]*@([\w]+)[\s]*(.*)')
        self.RE_SCHEMA_OBJECT = re.compile(r'[\s]*([\w]+)\.([\w]+)')

    def parse(self, text):
        '''Parses input string and returns list of DDLObjects'''
        in_comment = False
        result = []
        for s in iter(text.splitlines()):
            print('S={}'.format(s))
            rsc = self.RE_START_COMMENT.match(s)
            if rsc:
                if in_comment:
                    print('Double comment start!')
                in_comment = True
                comment = rsc.group(1)
                jdoc = JDOC('', '', comment)
            if in_comment:
                rcb = self.RE_COMMENT_BODY.match(s)
                rp = self.RE_PARAM.match(s)
                rec = self.RE_END_COMMENT.match(s)
                if rp:
                    if rsc:
                        print('Comment start and param on same line!')
                    param_name = rp.group(1)
                    param_desc = rp.group(2)
                    if param_name in ['function', 'trigger', 'procedure']:
                        rso = self.RE_SCHEMA_OBJECT.match(param_desc)
                        jdoc.object_type = param_name
                        if rso:
                            jdoc.schema_name = rso.group(1)
                            jdoc.object_name = rso.group(2)
                    elif param_name in ['return',
                                        'returns',
                                        'returning',
                                        'result']:
                        jdoc.returns = param_desc
                    else:
                        jdoc.add_param(param_name, param_desc)
                    print('Param {} = {}'.format(param_name, param_desc))
                if rcb:
                    comment = comment + ' ' + rcb.group(1)
                    jdoc.comment = comment
                if rec:
                    in_comment = False
                    result.append(copy.deepcopy(jdoc))
                    del jdoc
                    print('Comment:' + comment)
        return result
