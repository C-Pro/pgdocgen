'''
Created on 26.03.2015

@author: cpro
'''

import sys
import logging
import logging.handlers
from getopt import getopt
from configparser import ConfigParser


def parse_options(settings):
    '''Parse command line options'''
    optlist, args = getopt(sys.argv, 'x', [])
    settings['configfile'] = args[1]
    return settings


def load_config(settings):
    '''Load settings from configfile'''
    config = ConfigParser()
    section = 'pgdocgen'
    try:
        config.read(settings['configfile'])
    except Exception as e:
        sys.stderr.write('Failed to read config: ' + str(e))
        sys.exit(1)
    for option in config.options(section):
        settings[option] = config.get(section, option)
    return settings


def init_logging(settings, log):
    '''Set up logger'''
    lg_format = '%(asctime)s : - %(message)s'
    lg_dateformat = '%Y.%m.%d %H:%M:%S'
    logging.basicConfig(format=lg_format, datefmt=lg_dateformat)

    log = logging.getLogger('pgdocgen')

    handler = logging.handlers.WatchedFileHandler(filename = settings['log_file'] \
                                                  if 'log_file' in settings.keys() else None,
                                                  encoding='utf-8')
    formatter = logging.Formatter(fmt=lg_format, datefmt=lg_dateformat)
    handler.setFormatter(formatter)
    log.addHandler(handler)
    return log