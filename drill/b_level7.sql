--61
SELECT C.注文番号, C.注文枝番, C.商品コード, S.商品名, C.数量
  FROM 注文 AS C
  JOIN 商品 AS S
    ON C.商品コード = S.商品コード
 WHERE C.注文番号 = '201801130115'
 ORDER BY C.注文番号, C.注文枝番

--62
SELECT C.注文日, C.注文番号, C.注文枝番, C.数量, (H.単価 * C.数量) AS 注文金額
  FROM 注文 AS C
  JOIN 廃番商品 AS H
    ON C.商品コード = H.商品コード
 WHERE C.商品コード = 'A0009'
   AND T.注文日 > H.廃番日

--63
SELECT S.商品コード, S.商品名, S.単価, C.注文日, C.注文番号, C.数量,
       (S.単価 * C.数量) AS 売上金額
  FROM 商品 AS S
  JOIN 注文 AS C
    ON S.商品コード = C.商品コード
 WHERE S.商品コード = 'S0604'
 ORDER BY C.注文日

--64
SELECT C.商品コード, S.商品名
  FROM 注文 AS C
  JOIN 商品 AS S
    ON C.商品コード = S.商品コード
 WHERE C.注文日 >= '2016-08-01' AND C.注文日 <= '2016-08-31'

--65
-- SELECT C.商品コード, S.商品名, H.商品名 AS 廃番商品
--   FROM 注文 AS C
--   JOIN 商品 AS S
--     ON C.商品コード = C.商品コード
--   JOIN 廃番商品 AS H
--     ON C.商品コード = H.商品コード
--  WHERE C.注文日 >= '2016-08-01' AND C.注文日 <= '2016-08-31'
SELECT C.商品コード, COALESCE(S.商品名, '廃番') AS 商品名
  FROM 注文 AS C
  LEFT JOIN 商品 AS S
    ON C.商品コード = C.商品コード
 WHERE C.注文日 >= '2016-08-01' AND C.注文日 <= '2016-08-31'

--66
-- SELECT C.注文日, S.商品コード || ':' || S.商品名 AS 商品名, C.数量
--   FROM 商品 AS S
--   FULL JOIN 注文 AS C
--     ON S.商品コード = C.商品コード
--  WHERE S.商品区分 = '3'
 SELECT C.注文日, S.商品コード || ':' || S.商品名 AS 商品,
        COALESCE(C.数量, 0) AS 数量
   FROM 注文 AS C
  RIGHT JOIN 商品 AS S
     ON C.商品コード = S.商品コード
  WHERE S.商品区分 = '3'

--67
--  SELECT C.注文日, S.商品コード || ':' || S.商品名 AS 商品,
--         H.商品コード || ':' || (廃番済み) AS
--         COALESCE(C.数量, 0) AS 数量
--    FROM 注文 AS C
--   RIGHT JOIN 商品 AS S
--      ON C.商品コード = S.商品コード
--   WHERE S.商品区分 = '3'
  SELECT T.注文日, S.商品コード || ':' || S.商品名 AS 商品, COALESCE(T.数量, 0) AS 数量
  FROM 注文 AS T
  RIGHT JOIN
  (SELECT 商品コード, 商品名, 商品区分 FROM 商品
    UNION
  SELECT 商品コード, '（廃番済み）' AS 商品名, 商品区分
  FROM 廃番商品) AS S
  ON T.商品コード = S.商品コード
  WHERE S.商品区分 = '3'

--68
SELECT C.注文日, C.注文番号, C.注文枝番, C.商品コード,
       COALESCE(S.商品名, H.商品名) AS 商品名,
       COALESCE(S.単価, H.単価) AS 単価, C.数量,
       (COALESCE(S.単価, H.単価) * C.数量) - COALESCE(C.クーポン割引料, 0) AS 注文金額
  FROM 注文 AS C
  LEFT JOIN 商品 AS S
         ON T.商品コード = S.商品コード
  LEFT JOIN 廃番商品 AS H
         ON T.商品コード = H.商品コード
 WHERE C.注文番号 = '201704030010'

--69
-- SELECT S.商品コード, S.商品名, S.単価,
--        COALESCE(C.数量, 0) AS 売上数量, S.単価 * COALESCE(C.数量, 0) AS 総売上金額
--   FROM 商品 AS S
--   JOIN 注文 AS C
--     ON S.商品コード = C.商品コード
--  WHERE S.商品コード LIKE 'B%'
--  ORDER BY S.商品コード
SELECT S.商品コード, S.商品名, S.単価,
       COALESCE(C.数量, 0) AS 売上数量, S.単価 * COALESCE(C.数量, 0) AS 総売上金額
  FROM 商品 AS S
  LEFT JOIN (SELECT 商品コード, SUM(数量) AS 数量
               FROM 注文
              WHERE 商品コード LIKE 'B%'
              GROUP BY 商品コード) AS C
    ON S.商品コード = C.商品コード
 WHERE S.商品コード LIKE 'B%'
 ORDER BY S.商品コード

--70
SELECT S1.商品コード, S1.商品名,
       S2.商品コード AS 関連商品コード, S2.商品名 AS 関連商品名
  FROM 商品 AS S1
  JOIN 商品 AS S2
    ON S1.商品コード = S2.関連商品コード