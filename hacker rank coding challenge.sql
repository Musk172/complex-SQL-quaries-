select * from contest
select * from colleges
select * from challenges
select * from view_stats
select * from submittion_stats


select first.contest_id,first.hacker_id,first.name,
ISNULL(second.sum_total_sub,0) as total_submittion,ISNULL(second.sum_total_acc_sub,0) as total_accepted_submittion,
ISNULL(first.sum_total_views,0) as total_views,ISNULL(first.sum_total_uq_views,0) as total_unique_views
from(
select c.college_id,ct.contest_id,ct.hacker_id,ct.name,sum(vs.total_views) sum_total_views,
sum(vs.total_unique_views) sum_total_uq_views
from colleges c
join contest ct ON c.contest_id = ct.contest_id
join challenges ch ON c.college_id = ch.college_id
join view_stats vs on ch.challenge_id = vs.challenge_id
group by c.college_id,ct.contest_id,ct.hacker_id,ct.name) as first
full join
(select c.college_id,ct.contest_id,ct.hacker_id,ct.name,sum(ss.total_submittions) sum_total_sub,
sum(ss.total_accepted_submittions) sum_total_acc_sub
from colleges c
join contest ct ON c.contest_id = ct.contest_id
join challenges ch ON c.college_id = ch.college_id
join submittion_stats ss on ch.challenge_id = ss.challenge_id
group by c.college_id,ct.contest_id,ct.hacker_id,ct.name) as second 
ON first.college_id = second.college_id
where first.sum_total_views <> 0 OR first.sum_total_uq_views <> 0 or
second.sum_total_sub <> 0 OR second.sum_total_acc_sub <> 0
order by contest_id