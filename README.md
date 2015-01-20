# pgdocgen
=========
pgdocgen is a basic documentation generator for Postgresql schemas and PL/PgSQL code.
* It extracts schema description from `information_schema` tables and uses comments made with `comment on` sql command.
* It extracts description of stored functions from JavaDoc like format inspired with [HyperSQL](http://projects.izzysoft.de/trac/hypersql)

#### Usage:
```
pgdocgen path*to*sql*files source*files*extension output*directory project*name
```
#### Example:
```
pgdocgen /home/user/sql_schema sql /home/user/sql_schema/docs MyProject
```