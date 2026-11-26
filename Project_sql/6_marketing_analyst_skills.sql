/*
Question: What skills do marketing-focused Data Analyst roles require, and how do they pay?
- Filters Data Analyst postings whose job title mentions "marketing"
- Compares salary and posting volume against other Data Analyst roles
- Identifies the top skills for marketing analyst roles
- Why? Shows which skills matter for analysts who want to work in marketing
*/

-- Part A: Marketing vs. other Data Analyst roles
SELECT
    CASE 
        WHEN job_title ILIKE '%marketing%' THEN 'Marketing'
        ELSE 'Other'
    END AS role_group,
    COUNT(*) AS postings,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    role_group;


-- Part B: Top 10 skills for marketing Data Analyst roles
SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_Avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.job_title ILIKE '%marketing%' 
GROUP BY
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT 10;