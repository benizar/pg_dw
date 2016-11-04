/*
* Add comments
*/
create or replace function dms.refresh_mat_views()
returns trigger language plpgsql
as $$
begin
	refresh materialized view dms.face_to_face_inespain;
	refresh materialized view dms.give_me_five_inespain;
	refresh materialized view dms.map_catalog_inespain;
	refresh materialized view dms.one_by_one_inespain;

    --refresh materialized view dms.main;
    --refresh materialized view dms.docstore;
    --refresh materialized view dms.stats_general;
    --refresh materialized view dms.ui_general_options;
    --refresh materialized view dms.ui_map_catalog;
    	return null;
end $$;


create trigger refresh_mat_views
after insert or update or delete or truncate
on ods.main for each statement 
execute procedure dms.refresh_mat_views();
