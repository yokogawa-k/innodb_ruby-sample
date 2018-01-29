-- https://qiita.com/cobot00/items/8d59e0734314a88d74c7

CREATE DATABASE demo;

use demo;

CREATE TABLE base(
  id INT(11) NOT NULL AUTO_INCREMENT,
  value INT(5) NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

INSERT INTO base(value)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

CREATE TABLE demo1 (
  id1 int(11) NOT NULL AUTO_INCREMENT,
  data varchar(500) NOT NULL,
  PRIMARY KEY (id1)
);

INSERT INTO demo1(data)
SELECT
  CONCAT('happy-bose-cocky-euler-laughing-goldstine-DATA', @rownum := @rownum + 1)
FROM
  base AS b1,
  base AS b2,
  base AS b3,
  base AS b4,
  (select @rownum := 0) as v
;
