SELECT*
FROM Project..incidence;


SELECT*
FROM Project..Deaths;

--we will see Trends in incidence 

SELECT Americanstates,
SUM(Annualincidencecount)  AS TOTAL_INCIDENCE_COUNT,
RANK() OVER(ORDER BY SUM(Annualincidencecount) DESC) AS rank
FROM Project..incidence
GROUP BY Americanstates
HAVING Americanstates IS NOT NULL;

SELECT Americanstates,SUM(Annualincidencecount ) AS TOTAL_INCIDENCE_COUNT,
CASE 
    WHEN SUM(Annualincidencecount) <500 THEN 'low'
	WHEN SUM(Annualincidencecount) >=500 THEN 'High'
	ELSE NULL
	END AS SEVERITY
FROM Project..incidence
GROUP BY Americanstates
ORDER BY Americanstates;

SELECT Americanstates,RecentTrend,SUM(Annualincidencecount ) AS TOTAL_INCIDENCE_COUNT
FROM Project..incidence
GROUP BY Americanstates,RecentTrend
HAVING Americanstates IS NOT NUll 
ORDER BY Americanstates;



--
--Now we will see trends in deaths




SELECT  Americanstates,
SUM(Annualdeathcount)  AS TOTAL_DEATH_COUNT,
RANK() OVER(ORDER BY SUM(Annualdeathcount) DESC) AS rank
FROM Project..deaths
GROUP BY Americanstates
HAVING Americanstates IS NOT NULL;

SELECT  Americanstates,RecentTrend,SUM(Annualdeathcount) AS TOTAL_DEATH_COUNT
FROM Project..deaths
GROUP BY Americanstates,RecentTrend
HAVING Americanstates IS NOT NULL 
ORDER BY Americanstates;

SELECT Americanstates,SUM(Annualdeathcount ) AS TOTAL_DEATH_COUNT,
CASE 
    WHEN SUM(Annualdeathcount) <500 THEN 'low'
	WHEN SUM(Annualdeathcount) >=500 THEN 'High'
	ELSE NULL
	END AS SEVERITY
FROM Project..deaths
GROUP BY Americanstates
ORDER BY Americanstates;

 --JOINING BOTH TABLES
 CREATE VIEW CID AS
 SELECT i.Americanstates,ROUND(d.TOTAL_DEATH_COUNT /i.TOTAL_INCIDENCE_COUNT,2 ) AS MIR
 FROM
 (SELECT Americanstates,SUM(Annualincidencecount) AS TOTAL_INCIDENCE_COUNT
FROM Project..incidence
GROUP BY Americanstates
HAVING Americanstates IS NOT NULL) AS i
  INNER JOIN
 (SELECT  Americanstates,SUM(Annualdeathcount) AS TOTAL_DEATH_COUNT
FROM Project..deaths
GROUP BY Americanstates
HAVING Americanstates IS NOT NULL)AS d
 ON i.Americanstates=d.Americanstates;

 SELECT * FROM[CID];
                                             
 





