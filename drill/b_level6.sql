--55
SELECT 商品コード, 商品名, 単価,
       (SELECT SUM(数量)
         FROM 注文
         WHERE 商品コード = 'S0604') AS 数量
  FROM 商品
 WHERE 商品コード = 'S0604'

--56
UPDATE 注文
   SET 商品コード = (SELECT 商品コード
                     FROM 商品
                    WHERE 商品区分 = '2',
                      AND 商品名 LIKE '%ブーツ%'
                      AND 商品名 LIKE '%雨%'
                      AND 商品名 LIKE '%安心%')
 WHERE 注文日 = '2018-03-15'
   AND 注文番号 = '201803150014'
   AND 注文枝番 = 1

--57
SELECT 注文日, 商品コード
  FROM 注文
 WHERE 商品コード IN (SELECT 商品コード
                      FROM 商品
                     WHERE 商品名 LIKE '%あったか%')
 ORDER BY 注文日

--58
-- SELECT 商品コード, SUM(数量) AS 数量
--   FROM 注文
--  WHERE 数量 > ALL (SELECT AVG(数量)
--                     FROM 注文
--                    GROUP BY 商品コード)
SELECT 商品コード, SUM(数量) AS 数量
  FROM 注文
 GROUP BY 商品コード
HAVING SUM(数量) > ALL (SELECT AVG(数量)
                         FROM 注文
                        GROUP BY 商品コード)

--59
-- SELECT A. SUM(数量) AS 割引による販売数,
--        TRUNC(A. AVG(クーポン割引料), 0) AS 平均割引額
--   FROM (SELECT * FROM 注文
--          WHERE クーポン割引料 IS NOT NULL) AS A
--  WHERE 商品コード = 'W0746'
SELECT A.数量合計 AS 割引による販売数,
       TRUNC(A.割引料合計 / A.数量合計, 0) AS 平均割引額
  FROM (SELECT SUM(数量) AS 数量合計,
               SUM(クーポン割引料) AS 割引料合計
          FROM 注文
         WHERE 商品コード = 'W0746'
           AND クーポン割引料 IS NOT NULL) AS A

--60
-- INSERT INTO 注文
-- SELECT '2018-03-21', '201803210080', CAST(注文番号 AS INTEGER) + 1, 'S1003', 1, NULL
--   FROM 注文
INSERT INTO 注文
SELECT 注文日, 注文番号, MAX(注文枝番) + 1, 'S1003', 1, NULL
  FROM 注文
 WHERE 注文日 = '2018-03-21' AND 注文番号 = '201803210080'
 GROUP BY 注文日, 注文番号;
INSERT INTO 注文
SELECT 注文日, 注文番号, MAX(注文枝番) + 1, 'A0052', 2, 500
  FROM 注文
 WHERE 注文日 = '2018-03-22' AND 注文番号 = '201803220901'
 GROUP BY 注文日, 注文番号;