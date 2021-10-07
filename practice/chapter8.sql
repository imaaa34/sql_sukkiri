-- 8-2(1)
SELECT 社員番号, S.名前 AS 名前, B.名前 AS 部署名
  FROM 社員 AS S
  JOIN 部署 AS B
    ON S.部署ID = B.部署ID

-- 8-2(2)
SELECT 社員番号, S1.名前 AS 名前, S2.名前 AS 上司名
  FROM 社員 AS S1
  LEFT JOIN 社員 AS S2  -- 上司がNULLの可能性もある
    ON S1.上司ID = S2.社員番号

-- 8-2(3)
SELECT 社員番号, S1.名前 AS 名前, B.名前 AS 部署名, S2.名前 AS 勤務地
  FROM 社員 AS S1
  JOIN 部署 AS B
    ON S1.部署ID = B.部署ID
  JOIN 支店 AS S2
    ON S1.勤務地ID = S2.支店ID

-- 8-2(4)
SELECT 支店ID AS 支店コード, S1.名前 AS 支店名, S2.名前 AS 支店長名, T AS 社員数
  FROM 支店 AS S1
  JOIN 社員 AS S2
    ON S1.支店長ID = S2.社員番号
  JOIN (SELECT COUNT(*) AS 社員数, 勤務地ID FROM 社員 GROUP BY 勤務地ID) AS T
    ON S1.支店ID = T.勤務地ID

-- 8-2(5)
SELECT 社員番号, S1.名前 AS 名前, S3.名前 AS 本人勤務地, S4.名前 AS 上司勤務地
  FROM 社員 AS S1
  JOIN 社員 AS S2
    ON S1.上司ID = S2.社員番号
   AND S1.勤務地ID <> S2.勤務地ID  --AND以降、上司と勤務地が離れている場合
  JOIN 支店 AS S3
    ON S1.勤務地ID = S3.支店ID  --本人の勤務地
  JOIN 支店 AS S4
    ON S2.勤務地ID = S4.支店ID  --上司の勤務地