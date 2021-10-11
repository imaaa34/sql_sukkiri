-- 10-2
CREATE TABLE 学部 (
  ID  CHAR(1) PRIMARY KEY,
  学部 VARCHAR(20) NOT NULL UNIQUE,
  備考 VARCHAR(100) DEFAULT '特になし'
)

-- 10-3
CREATE TABLE 学生 (
  学籍番号  CHAR(8) PRIMARY KEY,
  名前     VARCHAR(30) NOT NULL,
  生年月日  DATE NOT NULL,
  血液型    CHAR(2) CHECK(血液型 IN ('A', 'B', 'O', 'AB') OR 血液型 IS NULL),
  学部ID    CHAR(1) REFERENCES 学部(ID)
)

-- 10-5
BEGIN;
UPDATE 学生
   SET 学部ID = 'K'
 WHERE 学部ID = 'R';
DELETE FROM 学部
 WHERE ID = 'R';
COMMIT;
-- 外部キー違反にならないためにUPDATEからDELETE