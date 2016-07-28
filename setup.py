#!/usr/bin/env python
from setuptools import setup, find_packages

setup(
    name='pgdocgen',
    version='0.4',
    packages=find_packages(),
    scripts=['pgdocgen/pgdocgen'],
    include_package_data=True,
    install_requires=[
        'psycopg2',
        'mako',
    ],
    # metadata for upload to PyPI
    author = "Sergey Melekhin",
    author_email = "cpro29a@gmail.com",
    description = "Documentation generator for Postgresql schema",
    license = "LGPL",
    keywords = ["postgresql","sql","ddl","documentation","generator"],
    url = "https://github.com/C-Pro/pgdocgen",
    download_url = "https://github.com/C-Pro/pgdocgen/tarball/0.4",
)
