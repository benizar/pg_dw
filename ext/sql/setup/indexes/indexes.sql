-- Index for give_me_pids
CREATE INDEX give_me_pids_idx ON dms.main (whose_provider_short, what_project_short, ST_GeoHash(where_boundary), when_reference);

-- Indexes for give_me_pyramids
CREATE INDEX give_me_pyramids_big_groups_idx ON dms.data_big_groups (pid);
CREATE INDEX give_me_pyramids_five_years_idx ON dms.data_five_years (pid);
CREATE INDEX give_me_pyramids_raw_idx ON dms.data_raw (pid);
CREATE INDEX give_me_pyramids_ten_years_idx ON dms.data_ten_years (pid);

CREATE INDEX give_me_pyramids_big_groups_percentages_idx ON dms.data_big_groups_percentages (pid);
CREATE INDEX give_me_pyramids_five_years_percentages_idx ON dms.data_five_years_percentages (pid);
CREATE INDEX give_me_pyramids_raw_percentages_idx ON dms.data_raw_percentages (pid);
CREATE INDEX give_me_pyramids_ten_years_percentages_idx ON dms.data_ten_years_percentages (pid);

--Cluster based on indexes
CLUSTER dms.main USING give_me_pids_idx;

CLUSTER dms.data_big_groups USING give_me_pyramids_big_groups_idx;
CLUSTER dms.data_five_years USING give_me_pyramids_five_years_idx;
CLUSTER dms.data_raw USING give_me_pyramids_raw_idx;
CLUSTER dms.data_ten_years USING give_me_pyramids_ten_years_idx;

CLUSTER dms.data_big_groups_percentages USING give_me_pyramids_big_groups_percentages_idx;
CLUSTER dms.data_five_years_percentages USING give_me_pyramids_five_years_percentages_idx;
CLUSTER dms.data_raw_percentages USING give_me_pyramids_raw_percentages_idx;
CLUSTER dms.data_ten_years_percentages USING give_me_pyramids_ten_years_percentages_idx;
