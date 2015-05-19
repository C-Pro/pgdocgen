from pgdocgen.parser import JDOC


def readddl(db):
    '''Walks down database objects and generates
    JDOC objects for table descriptions'''
    jdoc = []
    for schema in db.contents:
        j = JDOC(None,
                 schema.object_name,
                 schema.comment)
        j.object_type = 'schema'
        jdoc.append(j)
        for table in schema.contents:
            j = JDOC(table.schema_name,
                     table.object_name,
                     table.comment)
            j.object_type = 'table'
            for c in table.contents:
                j.params.append(c)
            jdoc.append(j)
    return jdoc
