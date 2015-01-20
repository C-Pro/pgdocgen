#!/usr/bin/env python
from setuptools import setup, find_packages


setup(
    name='pgdocgen',
    version='0.1',
    packages=find_packages(),
    scripts=['pgdocgen/pgdocgen'],
    include_package_data=True,
    install_requires=[
        'psycopg2',
        'mako',
    ],
)
