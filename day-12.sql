-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

with cte as (
select u.user_id as user_id, date(m.sent_at) as sent_date,  count(m.message_id) as message_count from npn_users u
left join npn_messages m
on u.user_id = m.sender_id
group by u.user_id, date(m.sent_at)
),
rank as (
  select *, Dense_rank() over (partition by sent_date order by message_count desc) as rnk
  from cte
)

select user_id, sent_date, message_count from rank
where rnk = 1;
