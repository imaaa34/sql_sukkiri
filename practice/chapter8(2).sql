-- 8-2(1)
SELECT S.社員番号, S.名前, B.名前 AS 部署名
  FROM 社員 AS S
  JOIN 部署 AS B
    ON S.部署ID = B.部署ID

-- 8-2(2)
SELECT S.社員番号, S.名前, J.名前 AS 上司名
  FROM 社員 AS S
  LEFT JOIN 社員 AS J
    ON S.上司ID = J.社員番号

-- 8-2(3)
SELECT S.社員番号, S.名前, B.名前 AS 部署名, C.名前 AS 勤務地
  FROM 社員 AS S
  JOIN 部署 AS B
    ON S.部署ID = B.部署ID
  JOIN 支店 AS C
    ON S.勤務地ID = C.支店ID

-- 8-2(4)
-- SELECT C.支店ID AS 支店コード, C.名前 AS 支店名, S.名前 AS 支店長名, COUNT(*) AS 社員数
--   FROM 支店 AS C
--   JOIN 社員 AS S
--     ON C.支店長ID = S.社員番号
SELECT C.支店ID AS 支店コード, C.名前 AS 支店名,
       S.名前 AS 支店長名, T.社員数 AS 社員数
  FROM 支店 AS C
  JOIN 社員 AS S
    ON C.支店長ID = S.社員番号
  JOIN (SELECT COUNT(*) AS 社員数, 勤務地ID
          FROM 社員
         GROUP BY 勤務地ID) AS T
    ON C.支店ID = T.勤務地ID

-- 8-2(5)
SELECT S.社員番号, S.名前, C.名前 AS 本人勤務地, C2.名前 AS 上司勤務地
  FROM 社員 AS S
  JOIN 社員 AS S2
    ON S.上司ID = S2.社員番号
   AND S.勤務地ID <> S2.勤務地ID
  JOIN 支店 AS C
    ON S.勤務地ID = C.支店ID
  JOIN 支店 AS C2
    ON S2.勤務地ID = S2.支店ID