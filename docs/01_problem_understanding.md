cat > docs/01_problem_understanding.md <<'EOF'
# Instagram Social Media Database - Problem Understanding

## 1. Project Overview

This project focuses on designing and implementing a relational database for an Instagram-like social media platform using PostgreSQL.

The database stores and manages information about users, posts, followers, likes, comments, hashtags, post media, and stories.

## 2. Problem Statement

A social media platform generates a large amount of interconnected data. Managing this data efficiently requires a well-designed database that maintains data accuracy, consistency, and integrity.

The objective is to design a relational database that supports common social media operations while ensuring that relationships between different entities are properly maintained.

## 3. Project Objectives

- Design a relational database with appropriate tables and relationships.
- Identify primary keys and foreign keys.
- Apply NOT NULL, UNIQUE, and CHECK constraints wherever required.
- Load the provided CSV seed data into PostgreSQL.
- Maintain data integrity and consistency.
- Support common social media queries efficiently.
- Analyze database performance and query execution.

## 4. Main Entities

The database consists of the following nine entities:

1. Users: Stores user profile and account information.
2. Follows: Stores relationships between followers and followed users.
3. Hashtags: Stores unique hashtags.
4. Posts: Stores posts created by users.
5. Post_Hashtags: Connects posts with hashtags.
6. Post_Media: Stores media files associated with posts.
7. Likes: Stores user likes on posts.
8. Comments: Stores comments and replies on posts.
9. Stories: Stores temporary stories shared by users.

## 5. Major Use Cases

- Register and maintain user profiles.
- Follow and unfollow other users.
- Create and retrieve posts.
- Like and unlike posts.
- Add comments and replies.
- Search posts using hashtags.
- Retrieve media associated with posts.
- Create and view stories.
- Retrieve followers and following information.

## 6. Data Integrity Requirements

The database must maintain correct relationships between records using primary keys and foreign keys.

Appropriate constraints will be applied to prevent invalid values, duplicate records, and missing mandatory information.

The database design must also accept all valid records present in the provided seed data.

## 7. Performance Requirements

The database should support the supplied workload of 30 SQL queries.

Query execution time will be measured using EXPLAIN (ANALYZE, BUFFERS). Performance optimization will be performed in later project phases.

## 8. Conclusion

The project aims to build a reliable and scalable relational database for an Instagram-like social media platform. A properly structured schema, suitable constraints, and performance analysis will help maintain data integrity and support efficient data retrieval.
EOF