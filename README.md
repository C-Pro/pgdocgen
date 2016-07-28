# pgdocgen
[![Build Status](https://travis-ci.org/C-Pro/pgdocgen.svg?branch=master)](https://travis-ci.org/C-Pro/pgdocgen)
=========

pgdocgen is a basic documentation generator for Postgresql schemas and PL/PgSQL code.
* It extracts schema description from `information_schema` tables and uses comments made with `comment on` sql command.
* It extracts description of stored functions from JavaDoc like format inspired by [HyperSQL](http://projects.izzysoft.de/trac/hypersql)

#### Comment format example:
```
/**The coolest function ever
*@function foo.bar
*@param in integer p_id THE identifier
*@param in varchar p_name bar name
*@return integer error code
*/
```

#### Config file
To build documentation you should create configuration file.
Take a look at pgdocgen/tests/test.ini:

```
[pgdocgen]
db_connect_string=dbname=test_pgdocgen user=test_pgdocgen port=5432 password=aoijrm39R host=127.0.0.1
log_file=test.log
input_dir=test_sql
input_ext=sql
output_dir=out_html
project_name=Pgdocgen test project
;default_schema=s2
```

Config parameters:
* db_connect_string [optional] - connection string to live database to extract DDL information (pgdocgen extracts table descriptions from database)
* input_dir [optional] - directory full of sql files with your stored procedures commented in JavaDoc-like format described earlier ^^
* input_ext - extension of input files. You can really comment code in any language using this syntax, maybe you'll want to change this parameter to something other than 'sql' :)
* output_dir - where pgdocgen will output html documentation
* project_name - this will be used for page titles
* default_schema - is used for functions created without implicitly specifying schema (eg. via search_path) if not set "public" will be used


#### Usage:
```
pgdocgen config.file
```
