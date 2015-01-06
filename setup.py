#!/usr/bin/env python
from setuptools import setup, find_packages


setup(
    name='pgdocgen',
    version='0.1',
    packages=find_packages(),
    install_requires=[
        'psycopg2',
        'mako',
    ],
)
