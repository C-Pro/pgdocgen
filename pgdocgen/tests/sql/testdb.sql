create user test_pgdocgen with password 'aoijrm39R';
create database test_pgdocgen with owner test_pgdocgen;
\c test_pgdocgen
create schema s1 authorization test_pgdocgen;
create schema s2 authorization test_pgdocgen;
comment on schema s2 is 's2 schema comment';
create table s1.t1
(
    x integer,
    y boolean
);
alter table s1.t1 owner to test_pgdocgen;
comment on table s1.t1 is 't1 comment';
comment on column s1.t1.x is 'column comment';
create table s2.t2
(
    z varchar
);
alter table s2.t2 owner to test_pgdocgen;
