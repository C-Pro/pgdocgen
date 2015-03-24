'''Module with functions to merge objects read from database and JDOC from files'''
from pgdocgen.ddlobject.db import DB
from pgdocgen.parser import JDOC


def merge_doc(jdoc,db):
  '''Function to merge function descriptions from JDOC
  and table descriptions from DB'''
