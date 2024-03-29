-- OUTER JOIN(외부 조인)
-- LEFT OUTER JOIN

SELECT *
  FROM TableA A
  LEFT OUTER JOIN TableB B
    ON A.key = B.key;

SELECT *
  FROM TableB B
 RIGHT OUTER JOIN TableA A
    ON A.key = B.key;
