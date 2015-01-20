# pgdocgen
=========
pgdocgen is a basic documentation generator for Postgresql schemas and PL/PgSQL code.
* It extracts schema description from `information_schema` tables and uses comments made with `comment on` sql command.
* It extracts description of stored functions from JavaDoc like format inspired with [HyperSQL](http://projects.izzysoft.de/trac/hypersql)

Comment format example:
```
/**The coolest function ever
*@function foo.bar
*@param in integer p_id THE identifier
*@param in varchar p_name bar name
*@return integer error code
*/
```

#### Usage:
```
pgdocgen path*to*sql*files source*files*extension output*directory project*name
```
#### Example:
```
pgdocgen /home/user/sql_schema sql /home/user/sql_schema/docs MyProject
```