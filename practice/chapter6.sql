-- 6-1(1)
SELECT AVG(降水量), AVG(最高気温), AVG(最低気温)
  FROM 都市別気象観測

-- 6-1(2)
SELECT SUM(降水量), AVG(最高気温), AVG(最低気温)
  FROM 都市別気象観測
 WHERE 都市名 = '東京'

-- 6-1(3)
SELECT 都市名, AVG(降水量), MIM(最高気温), MAX(最低気温)
  FROM 都市別気象観測
 GROUP BY 都市名

-- 6-1(4)
SELECT 月, AVG(降水量), AVG(最高気温), AVG(最低気温)
  FROM 都市別気象観測
 GROUP BY 月

-- 6-1(5)
SELECT 都市名, MAX(最高気温)
  FROM 都市別気象観測
 GROUP BY 都市名
 WHERE MAX(最高気温) >= 38

-- 6-1(6)
SELECT 都市名, MIN(最低気温)
  FROM 都市別気象観測
 GROUP BY 都市名
 WHERE MIN(最低気温) <= -10

-- 6-2(1)
SELECT COUNT(*) AS 入室中の社員数
  FROM 入退室管理
 WHERE 退室 IS NULL

-- 6-2(2)
SELECT 社員名, COUNT(*) AS 入室回数
  FROM 入退室管理
 GROUP BY 社員名
 ORDER BY 2 DESC

-- 6-2(3)
SELECT CASE 事由区分 WHEN '1' THEN 'メンテナンス'
                    WHEN '2' THEN 'リリース作業'
                    WHEN '3' THEN '障害対応'
                    WHEN '9' THEN 'その他'
        END AS 事由, COUNT(*) AS 入室回数
  FROM 入退室管理
 GROUP BY 事由区分

-- 6-2(4)
SELECT 社員名, COUNT(*) AS 入室回数
  FROM 入退室管理
 GROUP BY 社員名
HAVING COUNT(*) > 10

-- 6-2(5)
-- SELECT 日付, COUNT(*) AS 社員数
--   FROM 入退室管理
--  WHERE 事由区分 = '3'
SELECT 日付, COUNT(社員名) AS 対応社員数
  FROM 入退室管理
 WHERE 事由区分 = '3'
 GROUP BY 日付