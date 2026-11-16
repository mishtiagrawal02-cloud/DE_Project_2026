\set ON_ERROR_STOP on

SET search_path TO instagram;

-- 1. USERS
\copy users FROM 'seed_data/users.csv' WITH (FORMAT csv, HEADER true);

-- 2. HASHTAGS
\copy hashtags FROM 'seed_data/hashtags.csv' WITH (FORMAT csv, HEADER true);

-- 3. POSTS
\copy posts FROM 'seed_data/posts.csv' WITH (FORMAT csv, HEADER true);

-- 4. FOLLOWS
\copy follows FROM 'seed_data/follows.csv' WITH (FORMAT csv, HEADER true);

-- 5. POST_HASHTAGS
\copy post_hashtags FROM 'seed_data/post_hashtags.csv' WITH (FORMAT csv, HEADER true);

-- 6. POST_MEDIA
\copy post_media FROM 'seed_data/post_media.csv' WITH (FORMAT csv, HEADER true);

-- 7. LIKES
\copy likes FROM 'seed_data/likes.csv' WITH (FORMAT csv, HEADER true);

-- 8. COMMENTS
\copy comments FROM 'seed_data/comments.csv' WITH (FORMAT csv, HEADER true);

-- 9. STORIES
\copy stories FROM 'seed_data/stories.csv' WITH (FORMAT csv, HEADER true);

-- Update table statistics
ANALYZE;
