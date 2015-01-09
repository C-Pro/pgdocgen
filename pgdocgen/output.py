'''Html output generator (uses mako templates)'''

import os

from mako.template import Template
from mako.lookup import TemplateLookup

class HtmlGenerator(object):
    '''Html generator object.'''


    def generate_html(self, jdoc, schema):
        '''Generates html for a subset of jdoc records describing objects of specific schema'''

        template_dir = os.path.dirname(os.path.abspath(__file__))+'/templates'
        lookup = TemplateLookup(directories=[template_dir],
                                module_directory='/dev/shm',
                                input_encoding='utf-8',
                                output_encoding='utf-8',
                                encoding_errors='replace')

        params = { 'jdoc': [j for j in jdoc if j.schema_name == schema],
                   'schema_name': schema }
        template = lookup.get_template('functions.mako')
        html = template.render_unicode(**params)

        return html


    def write_files(self, jdoc, output_dir):
        '''Writes all jdoc records into files. One file per schema.'''

        #get all distinct schema names from jdoc:
        schemas = set([j.schema_name for j in jdoc])

        for schema in schemas:
          with open(output_dir + os.sep + schema + '.html','w') as f:
            f.write(self.generate_html(jdoc,schema))
          