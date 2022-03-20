create or replace procedure f1.init_population(csv_dir text)
language plpgsql
as $$
declare
    table_record record;
    file_path text;
    query text;
    row_count int;
begin
    for table_record in select table_name from information_schema.tables where table_schema = 'f1' and table_type = 'BASE TABLE'
    loop
        file_path := concat(csv_dir, '\', table_record.table_name, '.csv');
        query := format('copy f1.%s from ''%s'' csv header null ''\N''', table_record.table_name, file_path);
        execute query;
        get diagnostics row_count = row_count;
        raise notice 'Loaded % records into table f1.%', row_count, table_record.table_name;
    end loop;
end;
$$;


create or replace procedure f1.init_population(s3_bucket text, s3_stem text, aws_region text)
language plpgsql
as $$
declare
    table_record record;
    s3_path text;
    row_count int;
begin
    for table_record in
        select table_name
        from information_schema.tables
        where table_schema = 'f1'
        and table_type = 'BASE TABLE'
    loop
        s3_path := s3_stem || '/' || table_record.table_name || '.csv';
        perform aws_s3.table_import_from_s3(
            'f1.' || table_record.table_name,
            '',
            '(format csv, header true, null ''\N'')',
            aws_commons.create_s3_uri(s3_bucket, s3_path, aws_region)
        );
        raise notice 'Loaded table f1.%', table_record.table_name;
    end loop;
end;
$$;

