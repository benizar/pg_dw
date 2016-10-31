-- Index for give_me_pids
CREATE INDEX give_me_pids_idx ON dms.docstore (ST_GeoHash(where_centroid));

-- Indexes for give_me_pyramids
CREATE INDEX give_me_pyramids_idx ON dms.docstore (pid);

CREATE INDEX on dms.docstore USING GIN (payload);

--Cluster based on indexes
CLUSTER dms.docstore USING give_me_pids_idx;
CLUSTER dms.docstore USING give_me_pyramids_idx;
