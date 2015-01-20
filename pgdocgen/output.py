'''Html output generator (uses mako templates)'''

import os
from mako.template import Template
from mako.lookup import TemplateLookup

class HtmlGenerator(object):
    '''Html generator object.'''

    def __init__(self, project_name):
        '''Define templates directory'''
        self.project_name = project_name
        from pgdocgen import PATH
        self.template_dir = PATH +'/templates'
        self.lookup = TemplateLookup(directories=[self.template_dir],
                                     input_encoding='utf-8',
                                     output_encoding='utf-8',
                                     encoding_errors='replace')

    def generate_html(self, jdoc, schema, schemas):
        '''Generates html for a subset of jdoc records describing objects of specific schema'''

        params = { 'jdoc': [j for j in jdoc if j.schema_name == schema],
                   'schema_name': schema,
                   'schemas': schemas,
                   'project': self.project_name,
                   'title': '{}: functions in schema {}'.format(self.project_name,schema)}
        template = self.lookup.get_template('functions.mako')
        html = template.render_unicode(**params)

        return html

    def generate_index(self, schemas):
        '''Generates html for an index file'''

        params = { 'schemas': schemas,
                   'project': self.project_name,
                   'title': '{}: Database schema documentation'.format(self.project_name)}
        template = self.lookup.get_template('index.mako')
        html = template.render_unicode(**params)
        return html

    def write_files(self, jdoc, output_dir):
        '''Writes all jdoc records into files. One file per schema plus index file.'''

        #get all distinct schema names from jdoc:
        schemas = set([j.schema_name for j in jdoc if j.schema_name != ''])

        for schema in schemas:
          with open(output_dir + os.sep + schema + '.html', 'w') as f:
            f.write(self.generate_html(jdoc,schema,schemas))
        with open(output_dir + os.sep + 'index.html', 'w') as f:
          f.write(self.generate_index(schemas))
