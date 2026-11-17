CREATE SCHEMA IF NOT EXISTS instagram;
SET search_path TO instagram;

-- 1. USERS
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    username TEXT NOT NULL UNIQUE CHECK (BTRIM(username) <> ''),
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE CHECK (BTRIM(email) <> ''),
    bio TEXT,
    account_type TEXT NOT NULL
        CHECK (account_type IN ('PERSONAL', 'CREATOR', 'BUSINESS')),
    is_private BOOLEAN NOT NULL,
    is_verified BOOLEAN NOT NULL,
    followers_count INTEGER NOT NULL CHECK (followers_count >= 0),
    following_count INTEGER NOT NULL CHECK (following_count >= 0),
    created_at TIMESTAMPTZ NOT NULL
);

-- 2. FOLLOWS
CREATE TABLE follows (
    follower_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    followee_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    status TEXT NOT NULL CHECK (status IN ('ACCEPTED', 'PENDING')),
    created_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (follower_id, followee_id),
    CHECK (follower_id <> followee_id)
);

-- 3. HASHTAGS
CREATE TABLE hashtags (
    hashtag_id INTEGER PRIMARY KEY,
    tag TEXT NOT NULL UNIQUE CHECK (BTRIM(tag) <> '')
);

-- 4. POSTS
CREATE TABLE posts (
    post_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    post_type TEXT NOT NULL
        CHECK (post_type IN ('PHOTO', 'VIDEO', 'CAROUSEL', 'REEL')),
    caption TEXT,
    location_name TEXT,
    like_count INTEGER NOT NULL DEFAULT 0 CHECK (like_count >= 0),
    comment_count INTEGER NOT NULL DEFAULT 0 CHECK (comment_count >= 0),
    is_archived BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL
);

-- 5. POST_HASHTAGS
CREATE TABLE post_hashtags (
    post_id INTEGER NOT NULL REFERENCES posts(post_id) ON DELETE CASCADE,
    hashtag_id INTEGER NOT NULL REFERENCES hashtags(hashtag_id) ON DELETE CASCADE,
    PRIMARY KEY (post_id, hashtag_id)
);

-- 6. POST_MEDIA
CREATE TABLE post_media (
    post_id INTEGER NOT NULL REFERENCES posts(post_id) ON DELETE CASCADE,
    position INTEGER NOT NULL CHECK (position > 0),
    media_type TEXT NOT NULL CHECK (media_type IN ('IMAGE', 'VIDEO')),
    media_url TEXT NOT NULL CHECK (BTRIM(media_url) <> ''),
    width INTEGER NOT NULL CHECK (width > 0),
    height INTEGER NOT NULL CHECK (height > 0),
    duration_sec NUMERIC(7,1) CHECK (duration_sec IS NULL OR duration_sec > 0),
    PRIMARY KEY (post_id, position)
);

-- 7. LIKES
CREATE TABLE likes (
    user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    post_id INTEGER NOT NULL REFERENCES posts(post_id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (user_id, post_id)
);

-- 8. COMMENTS
CREATE TABLE comments (
    comment_id INTEGER PRIMARY KEY,
    post_id INTEGER NOT NULL REFERENCES posts(post_id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    parent_comment_id INTEGER REFERENCES comments(comment_id) ON DELETE SET NULL,
    body TEXT NOT NULL CHECK (BTRIM(body) <> ''),
    is_hidden BOOLEAN NOT NULL,
    created_at TIMESTAMPTZ NOT NULL
);

-- 9. STORIES
CREATE TABLE stories (
    story_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    media_type TEXT NOT NULL CHECK (media_type IN ('IMAGE', 'VIDEO')),
    created_at TIMESTAMPTZ NOT NULL,
    expires_at TIMESTAMPTZ NOT NULL,
    view_count INTEGER NOT NULL CHECK (view_count >= 0),
    CHECK (expires_at > created_at)
);
