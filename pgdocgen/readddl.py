from pgdocgen.parser import JDOC


def readddl(db):
    '''Walks down database objects and generates
    JDOC objects for table descriptions'''
    jdoc = {}
    for schema in db.contents:
        j = JDOC(None,
                 schema.object_name,
                 schema.comment,
                 schema.object_type)
        jdoc[schema.object_name] = j
        for table in schema.contents:
            j = JDOC(table.schema_name,
                     table.object_name,
                     table.comment,
                     table.object_type)
            for c in table.contents:
                j.params.append(c)
            jdoc[j.key()] = j
    return jdoc
