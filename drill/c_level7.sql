--62
SELECT K.ルート番号, K.イベント番号, I.イベント名称, K.クリア結果
  FROM 経験イベント AS K
  JOIN イベント AS I
    ON K.イベント番号 = I.イベント番号
 WHERE クリア区分 = '1'
 ORDER BY K.ルート番号

--63
SELECT I.イベント番号, I.イベント名称, K.クリア区分
　FROM イベント AS I
  JOIN 経験イベント AS K
    ON I.イベント番号 = K.イベント番号
 WHERE タイプ = '1'

--64
SELECT I.イベント番号, I.イベント名称,
　　　  COALESCE(K.クリア区分, '未クリア') AS クリア区分
　FROM イベント AS I
  LEFT JOIN 経験イベント AS K
         ON I.イベント番号 = K.イベント番号
 WHERE タイプ = '1'

--65
SELECT P.ID, P.名称 AS なまえ,
       S.コード名称 AS 職業, J.コード名称 AS 状態
  FROM パーティー AS P
  JOIN (SELECT コード値, コード名称
          FROM コード
         WHERE コード種別 = '1') AS S  --職業
    ON P.職業コード = S.コード値
  JOIN (SELECT コード値, コード名称
          FROM コード
         WHERE コード種別 = '2') AS J  --状態
    ON P.状態コード = J.コード値
 ORDER BY ID

--66
SELECT P.ID, COALESCE(P.名称, '(仲間になっていない！)') AS なまえ,
       S.コード名称 AS 職業
  FROM パーティー AS P
 RIGHT JOIN (SELECT コード値, コード名称
               FROM コード
              WHERE コード種別 = '1') AS S
         ON P.職業コード = S.コード値

--67
-- SELECT K.イベント番号, K.クリア区分,
--        C.コード値 || ':' || C.コード名称 AS クリア結果
--   FROM 経験イベント AS K
--   LEFT JOIN (SELECT コード値, コード名称
--                FROM コード
--               WHERE コード種別 = '4') AS C
--          ON K.クリア区分 = C.コード値
SELECT E.イベント番号, E.クリア区分,
       C.コード値 || '：' || C.コード名称 AS クリア結果
  FROM 経験イベント E
  FULL JOIN (SELECT コード値, コード名称
               FROM コード
              WHERE コード種別 ='4') C
         ON E.クリア結果 = C.コード値

--68
SELECT I1.イベント番号, I1.イベント名称,
       I1.前提イベント番号, I2.イベント名称 AS 前提イベント名称
  FROM イベント AS I1
  JOIN イベント AS I2
    ON I1.前提イベント番号 = I2.イベント番号
 WHERE I1.前提イベント番号 IS NOT NULL

--69
SELECT I1.イベント番号, I1.イベント名称,
       I1.前提イベント番号, I2.イベント名称 AS 前提イベント名称,
       I1.後続イベント番号, I3.イベント名称 AS 後続イベント名称
  FROM イベント AS I1
  LEFT JOIN イベント AS I2
         ON I1.前提イベント番号 = I2.イベント番号  --前提がNULLでも抽出
  LEFT JOIN イベント AS I3
         ON I1.後続イベント番号 = I3.イベント番号  --後続がNULLでも抽出
 WHERE I1.前提イベント番号 IS NOT NULL
    OR I1.後続イベント番号 IS NOT NULL

--70
-- SELECT I1.イベント番号, I1.イベント名称, I2.前提イベント数
--   FROM イベント AS I1
--   JOIN (SELECT 前提イベント番号, COUNT(前提イベント番号) AS 前提イベント数
--           FROM イベント
--          WHERE 前提イベント番号 IS NOT NULL) AS I2
--     ON I1.前提イベント番号 = I2.イベント番号
SELECT E.イベント番号, E.イベント名称, Z.前提イベント数 
  FROM イベント E
  JOIN (SELECT 前提イベント番号,
               COUNT(前提イベント番号) AS 前提イベント数
          FROM イベント
         WHERE 前提イベント番号 IS NOT NULL
         GROUP BY 前提イベント番号) Z
    ON E.イベント番号 = Z.前提イベント番号
 ORDER BY E.イベント番号