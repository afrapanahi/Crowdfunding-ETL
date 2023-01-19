CREATE TABLE "backers" (
    "backer_id" varchar(10)   NOT NULL,
    "cf_id" int   NOT NULL,
    "first_name" varchar(50)  NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "email" varchar(100)   NOT NULL,
    CONSTRAINT "pk_backers" PRIMARY KEY (
        "backer_id"
     )
);
ALTER TABLE "backers" ADD CONSTRAINT "fk_backers_cf_id" FOREIGN KEY("cf_id")
REFERENCES "campaign" ("cf_id");
select * from backers

-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
select cf_id, outcome, backers_count into backer_counts from campaign 
where (outcome = 'live')
order by backers_count desc;   
select * from backer_counts

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
select ca.cf_id,ca.outcome,ca.backers_count into backer_counts2
from campaign as ca
inner join contacts as co on (ca.contact_id=co.contact_id)
where (ca.outcome = 'live')
order by backers_count desc;
select * from backer_counts2

drop table backer_counts2

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
select co.first_name,co.last_name, co.email, ca.goal - ca.pledged as "Remaining Goal Amount"
into email_contacts_remaining_goal_amount
from contacts as co
inner join campaign as ca on (ca.contact_id=co.contact_id)
where (ca.outcome = 'live')
order by "Remaining Goal Amount" desc;
select * from email_contacts_remaining_goal_amount
--drop table email_contacts_remaining_goal_amount

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
select co.email, co.first_name, co.last_name, ca.cf_id, ca.company_name, ca.description,ca.end_date, ca.goal - ca.pledged as "Left of Goal"
into email_backers_remaining_goal_amount
from backers as co
inner join campaign as ca on (ca.cf_id=co.cf_id)
where (ca.outcome = 'live')
order by last_name,email;
select * from email_backers_remaining_goal_amount
--drop table email_backers_remaining_goal_amount