SET search_path TO instagram;

-- Index 1: idx_comments_post_id
-- Supports: The outer filter of R13 (WHERE c.post_id = 59689) as well as query R04.
-- Why useful: Allows PostgreSQL to quickly locate the small subset of candidate comments
-- belonging to post 59689 via an Index Scan, avoiding a full sequential scan across all
-- 150,000 rows in the comments table.
CREATE INDEX idx_comments_post_id
ON comments(post_id);

-- Index 2: idx_comments_parent_comment_id
-- Supports: The subquery of R13 (WHERE r.parent_comment_id = c.comment_id) in the NOT EXISTS check.
-- Why useful: For each candidate comment from post 59689, allows instant index probing to verify
-- whether any reply exists pointing to this comment as its parent, avoiding full table scans of
-- comments for each candidate.
CREATE INDEX idx_comments_parent_comment_id
ON comments(parent_comment_id);

-- Index 3: idx_follows_followee_id
-- Supports: Confirmed purpose for R15 (and potential benefit to W04).
-- Why useful: The existing composite primary key (follower_id, followee_id) only supports lookups
-- by follower_id. This B-tree index on followee_id allows PostgreSQL to quickly find all incoming
-- followers for specific accounts (such as verified/creator accounts in R15) without sequentially
-- scanning all 258,588 rows of the follows table. For W04, it assists followee-based grouping.
-- It may also support other followee-based queries in the workload (such as R01, R09, R14, R21,
-- and W06), though measured improvements will be confirmed during benchmarking.
CREATE INDEX idx_follows_followee_id
ON follows(followee_id);
