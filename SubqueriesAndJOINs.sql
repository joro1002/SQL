SELECT e.`employee_id`, e.`job_title`, e.`address_id`, a.`address_text`
FROM `employees` AS e JOIN `addresses` AS a
ON e.`address_id` = a.`address_id`
ORDER BY e.address_id
LIMIT 5;

SELECT e.`first_name`, e.`last_name`, t.`name`, a.`address_text`
FROM `employees` AS e JOIN `addresses` AS a
ON e.`address_id` = a.`address_id`
JOIN `towns` AS t
ON t.`town_id` = a.`town_id`
ORDER BY e.`first_name`,
e.`last_name`
LIMIT 5;

SELECT e.`employee_id`, e.`first_name`, e.`last_name`, d.`name`
FROM `employees` AS e 
JOIN `departments` AS d
ON e.`department_id` = d.`department_id`
WHERE d.name = 'Sales'
ORDER BY e.`employee_id` DESC;

SELECT e.`employee_id`, e.`first_name`, e.`salary`, d.`name`
FROM `employees` AS e 
JOIN `departments` AS d
ON e.`department_id` = d.`department_id`
WHERE e.`salary` > 15000
ORDER BY d.department_id DESC
LIMIT 5;

SELECT e.`employee_id`, e.`first_name`
FROM `employees` AS e
LEFT JOIN `employees_projects` AS ep
ON e.`employee_id` = ep.`employee_id`
WHERE ep.project_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;

SELECT e.`first_name`, e.`last_name`, e.`hire_date`, d.`name` 
FROM `employees` AS e
JOIN `departments` AS d
ON e.`department_id` = d.`department_id`
WHERE e.hire_date >'1999-1-1' AND 
d.name = 'Sales' OR d.name = 'Finance'
ORDER BY e.hire_date;

SELECT ep.`employee_id`, e.`first_name`, p.`name`
FROM `employees` AS e
JOIN `employees_projects` AS ep
ON ep.`employee_id` = e.`employee_id`
JOIN `projects` AS p
ON p.`project_id` = ep.`project_id`
WHERE p.`start_date` > '2002-08-12' AND p.`end_date` IS NULL
ORDER BY e.`first_name`, p.name
LIMIT 5;

SELECT e.`employee_id`, e.`first_name`, 
CASE
	WHEN YEAR(p.`start_date`) >= 2005 THEN NULL
    ELSE p.`name`
	END
FROM `employees` AS e 
JOIN `employees_projects` AS ep
ON e.employee_id = ep.employee_id
JOIN `projects` AS p
ON ep.project_id = p.project_id
WHERE ep.employee_id = 24
ORDER BY p.name;


SELECT e.`employee_id`, e.`first_name`, e.`manager_id` AS 'manager_name', m.`first_name`
FROM `employees` AS e
JOIN `employees` AS m
ON m.employee_id = e.manager_id
WHERE e.manager_id IN (3,7)
ORDER BY e.first_name;

SELECT e.`employee_id`, CONCAT(e.`first_name`, ' ', e.`last_name`), CONCAT(m.`first_name`, ' ', m.`last_name`), d.`name`
FROM `employees` AS e
JOIN `employees` AS m
ON m.employee_id = e.manager_id
JOIN `departments` AS d
ON e.department_id = d.department_id
ORDER BY e.employee_id
LIMIT 5;

SELECT MIN(AverageSalary.avg) AS 'min_average_salary'
FROM (
	SELECT AVG(e.`salary`) AS 'avg'
    FROM `employees` AS e
    GROUP BY e.department_id
    ) AS AverageSalary;
    


SELECT mc.`country_code`, m.`mountain_range`, p.`peak_name`, p.`elevation`
FROM `peaks` AS p
JOIN `mountains_countries` AS mc
ON p.mountain_id = mc.mountain_id
JOIN `mountains` AS m
ON m.id = p.mountain_id
WHERE mc.country_code = 'BG' AND p.elevation > 2835
ORDER BY p.elevation DESC;


SELECT mc.`country_code`, COUNT(`mountain_id`) AS 'count'
FROM `mountains_countries` AS mc
JOIN `mountains` AS m
ON mc.mountain_id = m.id
JOIN `countries` AS c
ON c.country_code = mc.country_code
WHERE c.country_name IN ('United States', 'Russia', 'Bulgaria')
GROUP BY mc.country_code
ORDER BY count DESC;

SELECT c.`country_name`, r.`river_name` 
FROM `countries` AS c
LEFT JOIN `countries_rivers` AS cr
ON cr.country_code = c.country_code
LEFT JOIN `rivers` AS r
ON r.id = cr.river_id
WHERE c.continent_code = 'AF'
ORDER BY c.country_name
LIMIT 5;


SELECT COUNT(*) 
FROM `countries` AS c
LEFT JOIN `mountains_countries` AS mc
ON c.country_code = mc.country_code
WHERE mc.mountain_id IS NULL;


SELECT c.`country_name`, MAX(p.elevation) AS 'highest_peak_elevation', MAX(r.length) AS 'longest_river_length'
FROM `mountains_countries` AS mc
JOIN `countries` AS c
ON mc.country_code = c.country_code
JOIN `mountains` AS m
ON mc.mountain_id = m.id
JOIN `peaks` AS p
ON p.mountain_id = m.id
JOIN `countries_rivers` AS cr
ON cr.country_code = c.country_code
JOIN `rivers` AS r
ON r.id = cr.river_id
GROUP BY c.country_name
ORDER BY highest_peak_elevation DESC,
longest_river_length DESC,
c.country_name
LIMIT 5;
