/**Функция добавления навыка для необработанной вакансии
*@function vac.add_unprocessed_skill
*@param in integer p_unprocessed_id идентификатор необработанной вакансии
*@param in integer p_skill_id идентификатор навыка
*@param in integer p_skill_level_id уровень навыка
*@return integer unprocessed_id
*/
create or replace function vac.add_unprocessed_skill(p_unprocessed_id integer,
                                                     p_skill_id  in integer,
                                                     p_skill_level_id in integer default null)
returns integer
as $$
declare
 v_id int;
begin
 insert into vac.unprocessed_skills(unprocessed_id,
                                    skill_id,
                                    skill_level_id)
 values(p_unprocessed_id,p_skill_id,p_skill_level_id)
 returning p_unprocessed_id into v_id;
 return v_id;
exception when unique_violation then
 return null;
end;
$$ language plpgsql;

/**Функция удаления навыка необработанной вакансии
*@function vac.delete_unprocessed_skill
*@param in integer p_unprocessed_id идентификатор необработанной вакансии
*@param in integer p_skill_id идентификатор навыка
*@return integer unprocessed_id
*/
create or replace function vac.delete_unprocessed_skill(p_unprocessed_id integer,
                                                        p_skill_id  in integer)
returns integer
as $$
declare
 v_id int;
begin
 delete from vac.unprocessed_skills
 where unprocessed_id = p_unprocessed_id and
       skill_id = p_skill_id
 returning unprocessed_id into v_id;
 return v_id;
end;
$$ language plpgsql;

/**Функция удаления всех навыков необработанной вакансии
*@function vac.delete_unprocessed_skills
*@param in integer p_unprocessed_id идентификатор необработанной вакансии
*@return integer unprocessed_id
*/
create or replace function vac.delete_unprocessed_skills(p_unprocessed_id integer)
returns integer
as $$
declare
 v_id int;
begin
 delete from vac.unprocessed_skills
 where unprocessed_id = p_unprocessed_id;
 if found then
  return p_unprocessed_id;
 else
  return null;
 end if;
end;
$$ language plpgsql;


/**Функция добавления сертификата необработанной вакансии
*@function vac.add_unprocessed_certificate
*@param in integer p_unprocessed_id идентификатор необработанной вакансии
*@param in integer p_certificate_id идентификатор сертификата
*@return integer unprocessed_id
*/
create or replace function vac.add_unprocessed_certificate
                        (p_unprocessed_id integer,
                         p_certificate_id  in integer)
returns int
as $$
declare
 v_id int;
begin
 insert into vac.unprocessed_certificates(unprocessed_id,certificate_id)
 values(p_unprocessed_id,p_certificate_id)
 returning unprocessed_id into v_id;
 return v_id;
exception when unique_violation then
 return null;
end;
$$ language plpgsql;


/**Функция удаления сертификата необработанной вакансии
*@function vac.delete_unprocessed_certificate
*@param in integer p_unprocessed_id идентификатор необработанной вакансии
*@param in integer p_certificate_id идентификатор сертификата
*@return integer unprocessed_id
*/
create or replace function vac.delete_unprocessed_certificate
                                (p_unprocessed_id in integer,
                                 p_certificate_id  in integer)
returns int
as $$
declare
 v_id int;
begin
 delete from vac.unprocessed_certificates
 where unprocessed_id = p_unprocessed_id and
       certificate_id = p_certificate_id
 returning unprocessed_id into v_id;
 return v_id;
end;
$$ language plpgsql;

/**Функция удаления всех сертификатов необработанной вакансии
*@function vac.delete_unprocessed_certificates
*@param in integer p_unprocessed_id идентификатор необработанной вакансии
*@return integer unprocessed_id
*/
create or replace function vac.delete_unprocessed_certificates
                                (p_unprocessed_id in integer)
returns int
as $$
begin
 delete from vac.unprocessed_certificates
 where unprocessed_id = p_unprocessed_id;
 if found then
  return p_unprocessed_id;
 else
  return null;
 end if;
end;
$$ language plpgsql;

--------------------------------------
/**Функция добавления необходимого навыка для вакансии
*@function vac.add_vacancy_skill
*@param in integer p_vacancy_id идентификатор вакансии
*@param in integer p_skill_id идентификатор навыка
*@param in integer p_skill_level_id уровень навыка
*/
create or replace function vac.add_vacancy_skill(p_vacancy_id integer,
                                                 p_skill_id  in integer,
                                                 p_skill_level_id in integer default null)
returns boolean
as $$
begin
 insert into vac.vacancy_skills(vacancy_id,skill_id,skill_level_id)
 values(p_vacancy_id,p_skill_id,p_skill_level_id);
 return found;
exception when unique_violation then
 return true;
end;
$$ language plpgsql;

/**Функция удаления необходимого навыка для вакансии
*@function vac.delete_vacancy_skill
*@param in integer p_vacancy_id идентификатор должности
*@param in integer p_skill_id идентификатор навыка
*/
create or replace function vac.delete_vacancy_skill(p_vacancy_id integer,
                                                    p_skill_id  in integer)
returns boolean
as $$
begin
 delete from vac.vacancy_skills
 where vacancy_id = p_vacancy_id and
       skill_id = p_skill_id;
 return found;
end;
$$ language plpgsql;

/**Функция удаления всех навыков вакансии
*@function vac.delete_vacancy_skills
*@param in integer p_vacancy_id идентификатор должности
*@return int vacancy_id
*/
create or replace function vac.delete_vacancy_skills(p_vacancy_id integer)
returns integer
as $$
begin
 delete from vac.vacancy_skills
 where vacancy_id = p_vacancy_id;
 if found then
  return p_vacancy_id;
 else
  return null;
 end if;
end;
$$ language plpgsql;

--------------------------------------
/**Функция добавления необходимого сертификата для вакансии
*@function vac.add_vacancy_certificate
*@param in integer p_vacancy_id идентификатор вакансии
*@param in integer p_certificate_id идентификатор сертификата
*/
create or replace function vac.add_vacancy_certificate(p_vacancy_id integer,
                                                 p_certificate_id  in integer)
returns boolean
as $$
begin
 insert into vac.vacancy_certificates(vacancy_id,certificate_id)
 values(p_vacancy_id,p_certificate_id);
 return found;
exception when unique_violation then
 return true;
end;
$$ language plpgsql;

--------------------------------------
/**Функция удаления необходимого сертификата для вакансии
*@function vac.delete_vacancy_certificate
*@param in integer p_vacancy_id идентификатор должности
*@param in integer p_certificate_id идентификатор сертификата
*/
create or replace function vac.delete_vacancy_certificate(p_vacancy_id integer,
                                                    p_certificate_id  in integer)
returns boolean
as $$
begin
 delete from vac.vacancy_certificates
 where vacancy_id = p_vacancy_id and
       certificate_id = p_certificate_id;
 return found;
end;
$$ language plpgsql;

/**Функция удаления всех сертификатов вакансии
*@function vac.delete_vacancy_certificates
*@param in integer p_vacancy_id идентификатор должности
*@return int vacancy_id
*/
create or replace function vac.delete_vacancy_certificates(p_vacancy_id integer)
returns integer
as $$
begin
 delete from vac.vacancy_certificates
 where vacancy_id = p_vacancy_id;
 if found then
  return p_vacancy_id;
 else
  return null;
 end if;
end;
$$ language plpgsql;

--------------------------------------
/**Функция добавления адреса URL для поиска вакансий
*@function vac.add_vacancy_url
*@param in varchar p_url адрес, с которого начинать поиск вакансий
*@param in integer p_employer_id идентификатор работодателя
*@param in timestamp with time zone p_last_visited время последней попытки обращения
*@param in timestamp with time zone p_last_success время последнего успешного обращения
*@param in interval p_visit_interval период проверки обновлений
*@return integer идентификатор url или null в случае ошибки
*/
create or replace function vac.add_vacancy_url(p_url varchar,
                           p_employer_id integer default null,
                           p_last_visited timestamptz default null,
                           p_last_success timestamptz default null,
                           p_visit_interval interval default '1 day'::interval,
                           p_parser_settings json default null)
                         returns integer
as $$
declare
 v_vacancy_url_id integer;
begin
    insert into vac.vacancy_urls(url,
                     employer_id,
                     last_visited,
                     last_success,
                     visit_interval,
                     parser_settings)
     values (p_url,
         p_employer_id,
         p_last_visited,
         p_last_success,
         p_visit_interval,
         p_parser_settings)
        returning vacancy_url_id into v_vacancy_url_id;
    return v_vacancy_url_id;
end;
$$ language plpgsql;

/**Функция добавления адреса URL для поиска вакансий
*@function vac.add_vacancy_url
*@param in integer p_vacancy_url_id идентификатор URL
*@param in varchar p_url адрес, с которого начинать поиск вакансий
*@param in integer p_employer_id идентификатор работодателя
*@param in timestamp with time zone p_last_visited время последней попытки обращения
*@param in timestamp with time zone p_last_success время последнего успешного обращения
*@param in interval p_visit_interval период проверки обновлений
*@param in json p_parser_settings настройки парсера
*@return integer идентификатор url или null в случае ошибки
*/
create or replace function vac.alter_vacancy_url(p_vacancy_url_id integer,
                         p_url varchar default 'empty',
                             p_employer_id integer default -1,
                             p_last_visited timestamptz default date '9999-01-01',
                             p_last_success timestamptz default date '9999-01-01',
                             p_visit_interval interval default interval '-1 day',
                             p_parser_settings json default null)
                         returns integer
as $$
declare
 v_vacancy_url_id integer;
begin
    update vac.vacancy_urls
    set url = case p_url when 'empty' then url
                     else p_url
          end,
        employer_id =
              case p_employer_id when -1 then employer_id
                     else p_employer_id
          end,
        last_visited =
              case p_last_visited when date '9999-01-01' then last_visited
                                  else p_last_visited
              end,
        last_success =
              case p_last_success when date '9999-01-01' then last_success
                                  else p_last_success
              end,
        visit_interval =
              case p_visit_interval when interval '-1 day' then visit_interval
                                  else p_visit_interval
              end,
        parser_settings = coalesce(p_parser_settings,parser_settings)   --нельзя обnullить непустое поле     
    where vacancy_url_id = p_vacancy_url_id
    returning vacancy_url_id into v_vacancy_url_id;
    
    return v_vacancy_url_id;
end;
$$ language plpgsql;

/**Функция удаления адреса URL для поиска вакансий
*@function vac.delete_vacancy_url
*@param integer p_vacancy_url_id id удаляемого URL
*@param integer p_auth_user_id id пользователя, выполняющего операцию
*@return integer идентификатор удалённого URL или null в случае ошибки
*/
create or replace function vac.delete_vacancy_url(p_vacancy_url_id integer,
                                                  p_auth_user_id integer)
                        returns integer
as $$
declare
 v_vacancy_url_id integer;
begin
    update vac.vacancy_urls
     set del_date = now(),
         del_user = p_auth_user_id
     where vacancy_url_id = p_vacancy_url_id
       returning vacancy_url_id into v_vacancy_url_id;
       
    return v_vacancy_url_id;
end;
$$ language plpgsql;



--------------------------------------
/**Функция добавления шаблона
*@function vac.add_match_pattern
*@param in varchar p_pattern шаблон для поиска в тексте вакансии
*@param in integer p_auth_user_id идентификатор пользователя
*@return integer идентификатор шаблона
*/
create or replace function vac.add_match_pattern(p_pattern varchar,
                                                 p_auth_user_id integer)
                         returns integer
as $$
declare
 v_pattern_id integer;
begin
    p_pattern := replace(p_pattern,'ё','е');
         insert into vac.match_patterns(pattern,
                           pattern_string,
                           rec_user_id)
         values (plainto_tsquery('russian',p_pattern),
             lower(p_pattern),
             p_auth_user_id)
         returning pattern_id into v_pattern_id;

         perform log.writelog(p_application := system.get_application_by_name('db'),
                              p_user        := p_auth_user_id,
                              p_message     := 'Run vac.add_match_pattern pattern_id:'||
                                    v_pattern_id||' and p_pattern:'||p_pattern,
                              p_error_level := 5
                             );

    return v_pattern_id;
end;
$$ language plpgsql;

/**Функция изменения шаблона
*@function vac.alter_match_pattern
*@param in integer p_pattern_id идентифиактор шаблона для поиска в тексте вакансии
*@param in varchar p_pattern новое значение шаблона для поиска в тексте вакансии
*@param in integer p_auth_user_id идентификатор пользователя
*@return integer идентификатор шаблона или null, если не найден
*/
create or replace function vac.alter_match_pattern(p_pattern_id integer,
                           p_pattern varchar,
                           p_auth_user_id integer)
                         returns integer
as $$
declare
 v_pattern_id integer;
begin
    p_pattern := vac.normalize_text(p_pattern);
    
    update vac.match_patterns
     set pattern = plainto_tsquery('russian',p_pattern),
             pattern_string = lower(p_pattern),
             rec_user_id = p_auth_user_id
    where pattern_id = p_pattern_id
    returning pattern_id into v_pattern_id;

         perform log.writelog(p_application := system.get_application_by_name('db'),
                              p_user        := p_auth_user_id,
                              p_message     := 'Run vac.alter_match_pattern pattern_id:'||
                                    v_pattern_id||' and p_pattern:'||p_pattern,
                              p_error_level := 5
                             );

    return v_pattern_id;
end;
$$ language plpgsql;

/**Функция удаления шаблона
*@function vac.delete_match_pattern
*@param in integer p_pattern_id идентифиактор шаблона для поиска в тексте вакансии
*@param in integer p_auth_user_id идентификатор пользователя
*@return integer идентификатор шаблона или null, если не найден
*/
create or replace function vac.delete_match_pattern(p_pattern_id integer,
                                                    p_auth_user_id integer)
                         returns integer
as $$
declare
 v_pattern_id integer;
 v_sysdate timestamp := clock_timestamp();
begin
    update vac.match_patterns
    set end_date = v_sysdate,
        rec_user_id = p_auth_user_id
    where pattern_id = p_pattern_id
    and    v_sysdate between start_date and end_date
    returning pattern_id into v_pattern_id;

         perform log.writelog(p_application := system.get_application_by_name('db'),
                              p_user        := p_auth_user_id,
                              p_message     := 'Run vac.delete_match_pattern pattern_id:'||
                                    p_pattern_id,
                              p_error_level := 5
                             );

    return v_pattern_id;
end;
$$ language plpgsql;

----------------------------------------------------------------------
/**Функция добавления реакции на шаблон
*@function vac.add_pattern_match
*@param in integer p_pattern_id идентифиактор шаблона для поиска в тексте вакансии
*@param in integer p_industry_id идентификатор отрасли
*@param in integer p_department_id идентификатор отдела
*@param in integer p_skill_id идентификатор навыка
*@param in integer p_certificate_id идентификатор сертификата
*@param in integer p_job_id идентификатор должности
*@param in integer p_match_field_id идентификатор поля, к которому применяется шаблон
*@param in integer p_skill_level_id идентификатор уровня навыка
*@param in integer p_employer_id идентификатор работодателя
*@param in integer p_area_id идентификатор региона
*@param in integer domain_class_id идентификатор класса ПО
*@param in float   p_rate оценка вероятности срабатывания шаблона
*@param in integer p_auth_user_id идентификатор пользователя
*@return integer идентификатор записи
*/
create or replace function vac.add_pattern_match (p_pattern_id integer,
                          p_industry_id integer,
                          p_department_id integer,
                          p_skill_id    integer,
                          p_certificate_id integer,
                          p_job_id integer,
                          p_match_field_id integer,
                          p_skill_level_id integer,
                          p_employer_id integer,
                          p_area_id    integer,
                          p_domain_class_id integer,
                          p_rate float,
                          p_auth_user_id integer)
returns integer
as $$
declare
 v_pattern_match_id integer;
begin
        insert into vac.pattern_matching(pattern_id,
                             industry_id,
                             department_id,
                             skill_id,
                             certificate_id,
                             job_id,
                             match_field_id,
                             skill_level_id,
                             employer_id,
                             area_id,
                             domain_class_id,
                             rate,
                             rec_user_id)
         values (p_pattern_id,
             p_industry_id,
             p_department_id,
             p_skill_id,
             p_certificate_id,
             p_job_id,
             p_match_field_id,
             p_skill_level_id,
             p_employer_id,
             p_area_id,
             p_domain_class_id,
             p_rate,
             p_auth_user_id)
            returning pattern_match_id into v_pattern_match_id;

    return v_pattern_match_id;
exception when unique_violation
        then return null;
end;
$$ language plpgsql;

/**Функция изменения реакции на шаблон
*@function vac.alter_pattern_match
*@param in integer p_pattern_match_id идентификатор изменяемой записи
*@param in integer p_auth_user_id идентификатор пользователя
*@param in integer p_pattern_id идентифиактор шаблона для поиска в тексте вакансии
*@param in integer p_industry_id идентификатор отрасли
*@param in integer p_department_id идентификатор отдела
*@param in integer p_skill_id идентификатор навыка
*@param in integer p_certificate_id идентификатор сертификата
*@param in integer p_job_id идентификатор должности
*@param in integer p_match_field_id идентификатор поля, к которому применяется шаблон
*@param in integer p_skill_level_id идентификатор уровня навыка
*@param in integer p_employer_id идентификатор работодателя
*@param in integer p_area_id идентификатор региона
*@param in integer domain_class_id идентификатор класса ПО
*@param in float   p_rate оценка вероятности срабатывания шаблона
*@return integer идентификатор записи
*/
create or replace function vac.alter_pattern_match(p_pattern_match_id integer,
                           p_auth_user_id integer,
                           p_pattern_id integer default -1,
                           p_industry_id integer default -1,
                           p_department_id integer default -1,
                           p_skill_id    integer default -1,
                           p_certificate_id integer default -1,
                           p_job_id integer default -1,
                           p_match_field_id integer default -1,
                           p_skill_level_id integer default -1,
                           p_employer_id integer default -1,
                           p_area_id    integer default -1,
                           p_domain_class_id integer default -1,
                           p_rate float default 'Infinity'::float)
returns integer 
as $$
declare
 v_pattern_match_id integer;
begin
 
    update vac.pattern_matching
        set pattern_id =
            case p_pattern_id when -1 then pattern_id
                                      else p_pattern_id
            end,
            industry_id =
            case p_industry_id when -1 then industry_id
                                      else p_industry_id
            end,
            department_id =
            case p_department_id when -1 then department_id
                                      else p_department_id
            end,
            skill_id =
            case p_skill_id when -1 then skill_id
                                      else p_skill_id
            end,
            certificate_id =
            case p_certificate_id when -1 then certificate_id
                                      else p_certificate_id
            end,
            job_id =
            case p_job_id when -1 then job_id
                                      else p_job_id
            end,
            match_field_id =
            case p_match_field_id when -1 then match_field_id
                                      else p_match_field_id
            end,
            skill_level_id =
            case p_skill_level_id when -1 then skill_level_id
                                      else p_skill_level_id
            end,
            employer_id =
            case p_employer_id when -1 then employer_id
                                      else p_employer_id
            end,
            area_id =
            case p_area_id when -1 then area_id
                                      else p_area_id
            end,
            domain_class_id =
            case p_domain_class_id when -1 then domain_class_id
                                      else p_domain_class_id
            end,
            rate =
            case p_rate when 'Infinity'::float then rate
                                      else p_rate
            end,
            rec_user_id = p_auth_user_id
            
    where pattern_match_id = p_pattern_match_id
    and    clock_timestamp() between start_date and end_date
    returning pattern_match_id into v_pattern_match_id;
    
    return v_pattern_match_id;
exception when unique_violation
        then return null;
end;
$$ language plpgsql;

/**Функция удаления реакции на шаблон
*@function vac.delete_pattern_match
*@param in integer p_pattern_match_id идентификатор удаляемой записи
*@param in integer p_auth_user_id идентификатор пользователя
*@return integer идентификатор шаблона или null в случае ошибки
*/
create or replace function vac.delete_pattern_match (p_pattern_match_id integer,
                                                     p_auth_user_id integer)
returns integer
as $$
declare
 v_pattern_match_id integer;
begin
    update vac.pattern_matching
    set     end_date = clock_timestamp(),
            rec_user_id = p_auth_user_id
    where pattern_match_id = p_pattern_match_id
    returning pattern_match_id into v_pattern_match_id;

    return v_pattern_match_id;
end;
$$ language plpgsql;


/**Функция клонирования реакций на шаблон
*@function vac.clone_pattern
*@param in integer p_old_pattern_id идентификатор старого шаблона
*@param in integer p_new_pattern_id идентификатор нового шаблона
*@param in integer p_auth_user_id идентификатор пользователя
*@return integer идентификатор шаблона или null в случае ошибки
*/
create or replace function vac.clone_pattern(p_old_pattern_id integer,
                                             p_new_pattern_id integer,
                                             p_auth_user_id integer)
returns int
as
$$
declare
 v_match_row vac.pattern_matching;
begin
  for v_match_row in (select * 
                      from vac.pattern_matching 
                      where pattern_id = p_old_pattern_id
                      and    now() between start_date and end_date
                      )
  loop
        perform vac.add_pattern_match(p_pattern_id      := p_new_pattern_id,
                                      p_industry_id     := v_match_row.industry_id,
                                      p_department_id   := v_match_row.department_id,
                                      p_skill_id        := v_match_row.skill_id,
                                      p_certificate_id  := v_match_row.certificate_id,
                                      p_job_id          := v_match_row.job_id,
                                      p_match_field_id  := v_match_row.match_field_id,
                                      p_skill_level_id  := v_match_row.skill_level_id,
                                      p_employer_id     := v_match_row.employer_id,
                                      p_area_id         := v_match_row.area_id,
                                      p_domain_class_id := v_match_row.domain_class_id,
                                      p_rate            := v_match_row.rate,
                                      p_auth_user_id    := p_auth_user_id);
                                      
  end loop;

         perform log.writelog(p_application := system.get_application_by_name('db'),
                              p_user        := p_auth_user_id,
                              p_message     := 'Run vac.clone_pattern p_old_pattern_id:'||
                                    p_old_pattern_id || ' p_new_pattern_id:' || p_new_pattern_id,
                              p_error_level := 5
                             );

  return p_new_pattern_id;
exception when others then
  return null;
end;
$$ language plpgsql;

/**Функция, разбивающая шаблон на идентификаторы составляющих его словоформ
 заполняет массив new_words словами, не найденными в корпусе
 заполняет массив wordform_pattern идентификаторами словоформ шаблона
*@function vac.split_pattern_to_wordforms
*@param in varchar p_pattern строка шаблона
*@return vac.wordform_parse_type массив новых слов и массив идентификаторов словоформ
*/
create or replace function vac.split_pattern_to_wordforms(p_pattern varchar)
returns vac.wordform_parse_type
as $$
declare
   v_wordform_id integer;
   v_word varchar(40);
   v_result vac.wordform_parse_type;
begin
   --Преобразуем строку в массив идентификаторов словоформ
   foreach v_word in ARRAY regexp_split_to_array(vac.normalize_text(p_pattern),
                                                '[^0-9a-zа-яё\#\+\$\@]+',
                                                'i')
   loop
        if v_word is null or length(v_word) = 0 then
           continue;
        end if;
        v_wordform_id := min(wordform_id)
          from kb.wordforms where wordform = v_word;

        if v_wordform_id is null then
         v_result.new_words := v_result.new_words || v_word;
        else
         v_result.wordform_pattern := v_result.wordform_pattern || v_wordform_id;
        end if;
   end loop;
   return v_result;
end;
$$ language plpgsql;

/**Функция добавления шаблона в виде последовательности идентификаторов словоформ
*@function vac.add_wordform_pattern
*@param in varchar p_pattern строка шаблона
*@param in integer p_auth_user_id идентификатор пользователя
*@return json массив новых слов или идентификатор pattern_id
*/
create or replace function vac.add_wordform_pattern(p_pattern varchar,
                                                    p_auth_user_id integer)
returns json
as $$
declare
   v_split_result vac.wordform_parse_type;
   v_pattern_id integer;
   v_result json;
begin
   v_split_result := vac.split_pattern_to_wordforms(p_pattern);

   if array_length(v_split_result.new_words,1)>0 then
        --Если не все словоформы найдены
        v_result := array_to_json(v_split_result.new_words,true);
   else
        v_pattern_id := vac.add_match_pattern(p_pattern,p_auth_user_id);

        if v_pattern_id is null then
                return null;
        end if;
        
    insert into vac.wordform_patterns(pattern_id,wordform_id,position_num,rec_user_id)
    select v_pattern_id as pattern_id,
           wordform_id,
           row_number() over (partition by null) - 1 as position_num,
           p_auth_user_id as rec_user_id
    from unnest(v_split_result.wordform_pattern) wordform_id
    ;

        v_result := row_to_json(pattern_id,true)
                 from (select v_pattern_id) pattern_id;
   end if;
   return v_result;
end;
$$ language plpgsql;

/**Функция изменения шаблона и его представления в виде последовательности словоформ
*@function vac.alter_wordform_pattern
*@param in integer p_pattern_id идентифиактор шаблона для поиска в тексте вакансии
*@param in varchar p_pattern новое значение шаблона для поиска в тексте вакансии
*@return json идентификатор шаблона или массив новых слов
*/
create or replace function vac.alter_wordform_pattern(p_pattern_id integer,
                                                      p_pattern varchar,
                                                      p_auth_user_id integer)
                         returns json
as $$
declare
   v_split_result vac.wordform_parse_type;
   v_pattern_id integer;
   v_result json;
   v_cur record;
   v_found boolean;
begin
   v_split_result := vac.split_pattern_to_wordforms(p_pattern);
   
   if array_length(v_split_result.new_words,1)>0 then
        --Если не все словоформы найдены
        v_result := array_to_json(v_split_result.new_words);
   else
        v_pattern_id := vac.alter_match_pattern(p_pattern_id,p_pattern,p_auth_user_id);

        if v_pattern_id is null then
                return null;
        end if;

        update vac.wordform_patterns
        set end_date = now(),
            rec_user_id = p_auth_user_id,
            ts = clock_timestamp()
        where pattern_id = v_pattern_id
        and    clock_timestamp() between start_date and end_date
        ;
        
        with t as (
            update vac.wordform_patterns wfp
            set end_date = '9999-01-01'::date,
                    rec_user_id = p_auth_user_id,
                    ts = clock_timestamp()
            from (
                    select v_pattern_id as pattern_id,
                            wordform_id,
                            row_number() over (partition by null) - 1 as position_num
                    from unnest(v_split_result.wordform_pattern) wordform_id
                 ) as new_wfp
            where   wfp.pattern_id = new_wfp.pattern_id
            and     wfp.wordform_id = new_wfp.wordform_id
            and     wfp.position_num = new_wfp.position_num
            and     wfp.end_date <= now()
            returning wfp.pattern_id,
                      wfp.wordform_id,
                      wfp.position_num
            )
        insert into vac.wordform_patterns(pattern_id,wordform_id,position_num,rec_user_id)
        select v_pattern_id as pattern_id,
               wordform_id,
               row_number() over (partition by null) - 1 as position_num,
               p_auth_user_id as rec_user_id
        from unnest(v_split_result.wordform_pattern) wordform_id
        except
        select t.*,p_auth_user_id as rec_user_id from t
        ;

        v_result := row_to_json(pattern_id)
                 from (select v_pattern_id) pattern_id;
   end if;
   return v_result;
end;
$$ language plpgsql;


/**Функция удаления шаблона и его представления в виде последовательности словоформ
*@function vac.delete_wordform_pattern
*@param in integer p_pattern_id идентифиактор шаблона для поиска в тексте вакансии
*@return integer идентификатор шаблона или null, если не вышло
*/
create or replace function vac.delete_wordform_pattern(p_pattern_id integer,
                                                       p_auth_user_id integer)
                         returns integer
as $$
begin
        update vac.wordform_patterns
        set end_date = clock_timestamp(),
            rec_user_id = p_auth_user_id,
            ts = clock_timestamp()
        where pattern_id = p_pattern_id
        and    clock_timestamp() between start_date and end_date
        ;
        
        return vac.delete_match_pattern(p_pattern_id,p_auth_user_id);
end;
$$ language plpgsql;

/**Функция удаления необработанной вакансии
*@function  vac.drop_vacancy
*@param in integer p_unprocessed_id идентификатор необработанной вакансии
*@param in integer p_auth_user_id идентификатор пользователя
*@param in integer p_process_status_id идентификатор статуса вакансии
*@return unprocessed_id
*/
create or replace function vac.drop_vacancy(p_unprocessed_id in integer,
                                            p_auth_user_id in integer,
                                            p_process_status_id integer default 103)
returns integer
as
$$
declare
v_vacancy_id integer;
v_unprocessed_id integer;
begin
    update vac.unprocessed_vacancies
        set process_status_id = p_process_status_id
        where unprocessed_id = p_unprocessed_id
        returning vacancy_id,unprocessed_id
             into v_vacancy_id,v_unprocessed_id;

    if (p_process_status_id in (102,103,104) and v_vacancy_id is not null) then
        update vac.vacancies
            set del_date = now()
            where vacancy_id = v_vacancy_id
            and     del_date is null
        ;
        update vac.vacancies_search
            set del_date = now()
            where vacancy_id = v_vacancy_id
            and     del_date is null
        ;
    end if;

    if v_unprocessed_id is not null then
            perform log.writelog(p_application := system.get_application_by_name('db'),
                    p_user    := p_auth_user_id,
                    p_message     := 'Run vac.drop_vacancy with vacancy_id:'||
                        coalesce(v_vacancy_id::varchar,'null') ||' and unprocessed_id:'||p_unprocessed_id ||
                        ' process_status_id: ' || p_process_status_id,
                    p_error_level := 5
                    );
    end if;

    return v_unprocessed_id;
    
exception when others then
    perform log.writelog(p_application := system.get_application_by_name('vac'),
            p_user       := 1,
            p_message      := 'Exception in vac.drop_vacancy(p_unprocessed_id=' || p_unprocessed_id
                     || '):' || SQLERRM,
            p_error_level := 3
            );
    return null;
end;
$$ language plpgsql;


/**Ф-я добавления меток для оценки разбора вакансии
*@function vac.add_vacancy_parse_note
*@param integer p_unprocessed_id идентификатор необработанной вакансии
*@param text p_json_text json с отметками о качестве разбора
*@return p_unprocessed_id, если добавлена новая запись, null - если обновлена существующая
*/
create or replace function
        vac.add_vacancy_parse_note(p_unprocessed_id integer,
                                   p_json_text text)
returns integer
as $$
declare
 v_unprocessed_id int;
begin
 loop
      update vac.vacancy_parse_notes
         set notes = p_json_text::json,
             ts = now()
       where unprocessed_id = p_unprocessed_id
      returning unprocessed_id into v_unprocessed_id;
      if v_unprocessed_id is not null then
        return v_unprocessed_id;
      end if;
     
     begin
         insert into vac.vacancy_parse_notes
              values(p_unprocessed_id,
                     p_json_text::json)
              returning unprocessed_id into v_unprocessed_id;
         return v_unprocessed_id;
     exception when unique_violation then
      --NOOP
     end;
 end loop;
end;
$$ language plpgsql;

/**
 * Сохранение полей необработанной вакансии, используется для частичного редактирования необработанной вакансии
 * @function  vac.save_unprocessed_vacancy
 * @param in integer p_unprocessed_id идентификатор необработанной вакансии
 * @return integer unprocessed_id идентификатор изменённой вакансии или null
 */
create or replace function vac.save_unprocessed_vacancy(
    p_unprocessed_id in integer,
    p_name        varchar,
    p_vac_date        date,
    p_position_name    varchar,
    p_job_id        integer,
    p_company_name    varchar,
    p_industry_name     varchar,
    p_industry_id    integer,
    p_department_name   varchar,
    p_department_id     integer,
    p_city_name        varchar,
    p_area_id        integer,
    p_address        varchar,
    p_description    varchar,
    p_requirements    varchar,
    p_duties        varchar,
    p_terms        varchar,
    p_wage        varchar,
    p_phone        varchar,
    p_email        varchar,
    p_employer_id    integer)
returns integer
as $$
    update vac.unprocessed_vacancies
    set name = p_name,
    vac_date = p_vac_date,
    position_name = p_position_name,
    job_id = p_job_id,
    company_name = p_company_name,
    industry_name = p_industry_name,
    industry_id = p_industry_id,
    department_name = p_department_name,
    department_id = p_department_id,
    city_name = p_city_name,
    area_id = p_area_id,
    address = p_address,
    description = p_description,
    requirements = p_requirements,
    duties = p_duties,
    terms = p_terms,
    wage = p_wage,
    phone = p_phone,
    email = p_email,
    employer_id = p_employer_id
    where unprocessed_id = p_unprocessed_id
    returning unprocessed_id;
$$ language sql;

/**Функция, добавляющая или обновляющая время доступа к url
*@function vac.touch_url
*@param p_url url
*@param p_spider_id идентификатор паука из vac.spiders (обязательный)
*@param p_is_good стоит ли вообще заходить на эту url?
*@return visited_url_id
*/
create or replace function vac.touch_url(p_url varchar,
                                         p_spider_id integer,
                                         p_is_good boolean)
                         returns integer
as $$
declare
 v_visited_url_id integer;
begin
 insert into vac.visited_urls(spider_id,url,is_good)
        values(p_spider_id,p_url,p_is_good)
        returning visited_url_id into v_visited_url_id;
 return v_visited_url_id;
exception
 when UNIQUE_VIOLATION then
   update vac.visited_urls
      set ts = now(),
            is_good =p_is_good
    where url = p_url
   returning visited_url_id into v_visited_url_id;
   return v_visited_url_id;
end;
$$ language plpgsql;

/**Функция получения идентификатора паука по его имени, прописанному в справочнике vac.spiders
    *@function vac.get_spider_id

*@param in character varying p_spider_name имя паука

*@return integer идентификатор паука
*/
create or replace function vac.get_spider_id( p_spider_name character varying )
    returns integer
as
$$
declare
    v_spider_id integer;
begin
    select spider_id
      into strict v_spider_id
      from vac.spiders
     where name = p_spider_name;
    return v_spider_id;
end;
$$ language plpgsql;

/**Функция получения списка ссылок, которые не надо обрабатывать пауку
*@function vac.get_visited_urls
*@param in integer p_spider_id идентификатор паука
*@return setof character varying список ссылок
*/
create or replace function vac.get_visited_urls( p_spider_id integer )
    returns setof character varying
as $$
declare
 v_interval interval := (config.get_string_value('VAC_URLS_CRAWL_INTERVAL'))::interval;
begin
   return query
    select url from vac.visited_urls
     where spider_id = p_spider_id
       and is_good
       and ts > now() - v_interval
    order by url;
end;
$$ language plpgsql;



