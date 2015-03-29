/**Test function comment
*@function s1.function1()
*@param param1 int integer parameter
*@param param2 varchar string parameter
*@returns int record id
*/
create or replace function s1.function1(param1 int, param2 varchar2)
    returns int
as $$
insert into s1.t1 values(param1,param2) returning param1;
$$ langugage sql;

