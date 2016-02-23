/*
* Add comments
*/
create or replace function dms.refresh_mat_views()
returns trigger language plpgsql
as $$
begin
    refresh materialized view dms.main;
    refresh materialized view dms.data_big_groups;
    refresh materialized view dms.data_big_groups_percentages;
    refresh materialized view dms.data_five_years;
    refresh materialized view dms.data_five_years_percentages;
    refresh materialized view dms.data_raw;
    refresh materialized view dms.data_raw_percentages;
    refresh materialized view dms.data_ten_years;
    refresh materialized view dms.data_ten_years_percentages;
    refresh materialized view dms.stats_general;
    refresh materialized view dms.ui_general_options;
    refresh materialized view dms.ui_map_catalog;
    return null;
end $$;


create trigger refresh_mat_views
after insert or update or delete or truncate
on ods.main for each statement 
execute procedure dms.refresh_mat_views();
