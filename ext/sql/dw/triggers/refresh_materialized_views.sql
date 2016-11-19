/*
* Add comments
*/
create or replace function dms.refresh_all_views()
returns trigger language plpgsql
as $$
begin

	--refresh materialized view dms.map_catalog;

    	return null;
end $$;


create trigger refresh_all_views
after insert or update or delete or truncate
on ods.main for each statement 
execute procedure dms.refresh_all_views();
