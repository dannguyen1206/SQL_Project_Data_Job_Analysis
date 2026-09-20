/*
Find job postings from the first quarter that have a salary greater than $70K
- Combine job postings tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $70,000
*/

SELECT 
    q1_job_postings.job_title_short,
    q1_job_postings.job_location,
    q1_job_postings.job_via,
    q1_job_postings.job_posted_date::date,
    q1_job_postings.salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM febuary_jobs
    UNION ALL
    SELECT *
    FROM march_jobs) AS q1_job_postings
WHERE
    q1_job_postings.salary_year_avg > 70000
AND
    q1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    q1_job_postings.salary_year_avg DESC;
