-- https://qiita.com/cobot00/items/8d59e0734314a88d74c7
INSERT INTO demo1(data)
SELECT
  CONCAT('happy-bose-cocky-euler-laughing-goldstine-DATA', @rownum := @rownum + 1)
FROM
  base AS b1,
  base AS b2,
  base AS b3,
  (select @rownum := 3001) as v
;
