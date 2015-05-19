'''Html output generator (uses mako templates)'''

import os
import shutil
from mako.lookup import TemplateLookup
from pgdocgen.utils import get_logger


class HtmlGenerator(object):
    '''Html generator object.'''

    def __init__(self, project_name):
        '''Define templates directory'''
        self.project_name = project_name
        from pgdocgen import PATH
        self.template_dir = PATH + '/templates'
        self.lookup = TemplateLookup(directories=[self.template_dir],
                                     input_encoding='utf-8',
                                     output_encoding='utf-8',
                                     encoding_errors='replace')
        self.log = get_logger()

    def generate_html(self, jdoc, schema, schemas):
        '''Generates html for a subset of jdoc records
        describing objects of specific schema'''

        params = {'functions': sorted([j for j in jdoc \
                   if (j.schema_name == schema.object_name and j.object_type \
                       in ['function', 'procedure', 'trigger'])], \
                                      key=lambda x: x.object_name),
                   'tables': sorted([j for j in jdoc \
                   if (j.schema_name == schema.object_name and j.object_type \
                       in ['table', 'view'])], \
                                    key=lambda x: x.object_name),
                   'schema_name': schema.object_name,
                   'schemas': sorted(schemas, key=lambda x: x.object_name),
                   'project': self.project_name,
                   'title': '{}: schema {}'.format(self.project_name,
                                                   schema.object_name)}
        template = self.lookup.get_template('schema.mako')
        html = template.render_unicode(**params)

        return html

    def generate_index(self, schemas):
        '''Generates html for an index file'''

        params = {'schemas': sorted(schemas, key=lambda x: x.object_name),
                  'project': self.project_name,
                  'title': '{}: Database schema documentation'\
                  .format(self.project_name)}
        template = self.lookup.get_template('index_new.mako')
        html = template.render_unicode(**params)
        return html

    def write_files(self, jdoc, output_dir):
        '''Writes all jdoc records into files.
        One file per schema plus index file.'''

        #get all distinct schema names from jdoc:
        schemas = [j for j in jdoc if j.object_type == 'schema']
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)
        try:
            shutil.copytree(self.template_dir + os.sep + 'styles',
                            output_dir + os.sep + 'styles')
        except FileExistsError:
            None
        for schema in schemas:
            with open(output_dir + os.sep + schema.object_name + '.html', 'w') as f:
                f.write(self.generate_html(jdoc, schema, schemas))
        with open(output_dir + os.sep + 'index.html', 'w') as f:
            f.write(self.generate_index(schemas))
