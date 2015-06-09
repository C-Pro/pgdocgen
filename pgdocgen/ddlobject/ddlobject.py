'''DDL object description module'''


class DDLObject(object):
    '''Basic class for all DDL schema objects'''
    object_name = ''
    object_type = ''
    comment = ''
    contents = []
