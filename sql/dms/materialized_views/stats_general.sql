
/*
 *  Add comments
 */
CREATE MATERIALIZED VIEW dms.stats_general AS 
 SELECT row_to_json(stats.*)::text AS row_to_json
   FROM ( SELECT count(s.who_uploaded) AS pyramids_count,
            count(DISTINCT s.who_uploaded ORDER BY s.who_uploaded) AS who_uploaded,
            count(DISTINCT s.what_project ORDER BY s.what_project) AS what_project,
            count(DISTINCT s.when_reference ORDER BY s.when_reference) AS when_reference,
            count(DISTINCT s.whose_provider ORDER BY s.whose_provider) AS whose_provider
           FROM ( SELECT main.pid,
                    main.who_uploaded,
                    main.what_project,
                    main.when_reference,
                    main.whose_provider
                   FROM dms.main) s) stats
WITH DATA;
