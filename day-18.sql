-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

with date_rnk as(
select *, row_number() over (partition by subject order by quiz_date asc) as first_rn,
row_number() over (partition by subject order by quiz_date desc) as last_rn
from daily_quiz_scores
),
first as (
select subject, score as first_score from date_rnk
where first_rn = 1
)
select d.subject, first_score, score as last_score from date_rnk d
inner join first f
on d.subject = f.subject
where last_rn = 1
