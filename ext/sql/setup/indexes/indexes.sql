-- Index for give_me_pids
CREATE INDEX give_me_pids_idx ON dms.main (whose_provider_short, what_project_short, ST_GeoHash(where_boundary), when_reference);

-- Indexes for give_me_pyramids
CREATE INDEX give_me_pyramids_idx ON dms.docstore (pid);

CREATE INDEX on dms.docstore USING GIN (payload);


--Cluster based on indexes
CLUSTER dms.main USING give_me_pids_idx;
CLUSTER dms.docstore USING give_me_pyramids_idx;
