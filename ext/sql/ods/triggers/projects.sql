CREATE FUNCTION ods.projects()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
  proj_id int;
BEGIN
  -- 
  --INSERT INTO providers_list (longname,shortname,url,provider_id) VALUES (new.provider_longname,new.provider_shortname,new.provider_url);
  --INSERT INTO backers_list (nickname,firstname,lastname) VALUES (new.backer_nickname,new.backer_firstname,new.backer_lastname) RETURNING id INTO back_id;
  INSERT INTO projects_list (longname,shortname,refdate, baker_id, provider_id) VALUES (new.proj_longname,new.proj_shortname,new.proj_refdate, new.proj_backerid, new.proj_providerid) RETURNING id INTO proj_id;
  INSERT INTO users (pyrdata, pyrvariables, geoname, boundary, labelpoint, project_id) VALUES (new.pyr_data, new.pyr_variables, new.pyr_geoname, new.pyr_boundary, new.pyr_labelpoint, proj_id);
RETURN new;
END;
$$;

CREATE TRIGGER projects
INSTEAD OF INSERT ON ods.projects
FOR EACH ROW
EXECUTE PROCEDURE ods.projects();
