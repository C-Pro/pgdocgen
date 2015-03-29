from pgdocgen.parser import JDOC


def readddl(db):
    '''Walks down database objects and generates
    JDOC objects for table descriptions'''
    jdoc = []
    print(db.contents)
    for schema in db.contents:
        print(schema.object_name)
        for table in schema.contents:
            j = JDOC(table.schema_name,
                     table.object_name,
                     table.comment)
            j.object_type = 'table'
            for c in table.contents:
                j.params.append(c)
            jdoc.append(j)
    return jdoc
