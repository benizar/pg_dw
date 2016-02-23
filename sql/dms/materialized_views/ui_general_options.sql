
/*
 *  Add comments
 */
CREATE MATERIALIZED VIEW dms.ui_general_options AS 
 SELECT row_to_json(ui.*)::text AS row_to_json
   FROM ( SELECT array_agg(DISTINCT s.who_uploaded ORDER BY s.who_uploaded) AS who_uploaded,
            array_agg(DISTINCT s.what_project ORDER BY s.what_project) AS what_project,
            array_agg(DISTINCT s.what_project_short ORDER BY s.what_project_short) AS what_project_short,
            array_agg(DISTINCT s.what_variables) AS what_variables,
            array_agg(DISTINCT s.when_reference ORDER BY s.when_reference) AS when_reference,
            array_agg(DISTINCT s.whose_provider ORDER BY s.whose_provider) AS whose_provider,
            array_agg(DISTINCT s.whose_provider_short ORDER BY s.whose_provider_short) AS whose_provider_short
           FROM ( SELECT main.pid,
                    main.who_uploaded,
                    main.what_project,
                    main.what_project_short,
                    unnest(main.what_variables) AS what_variables,
                    main.when_reference,
                    main.whose_provider,
                    main.whose_provider_short
                   FROM dms.main) s) ui
WITH DATA;
