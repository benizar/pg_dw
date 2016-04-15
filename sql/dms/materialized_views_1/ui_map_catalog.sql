
/*
 *  Add comments
 */
CREATE MATERIALIZED VIEW dms.ui_map_catalog AS 
 SELECT row_to_json(ui.*)::text AS row_to_json
   FROM ( SELECT s.whose_provider_short,
            array_agg(DISTINCT s.what_project_short ORDER BY s.what_project_short) AS what_project_short
           FROM ( SELECT main.what_project_short,
                    main.whose_provider_short
                   FROM dms.main) s
          GROUP BY s.whose_provider_short) ui
WITH DATA;
