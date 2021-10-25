-- 7-3(1)
INSERT INTO 頭数集計
SELECT 飼育県, COUNT(個体識別番号) AS 頭数
  FROM 個体識別
 GROUP BY 飼育県

-- 7-3(2)
SELECT 飼育県 AS 都道府県名, 個体識別番号,
       CASE 雄雌 WHEN '1' THEN '雄'
                WHEN '2' THEN '雌'
        END AS 雄雌
  FROM 個体識別
 WHERE 飼育県 IN (SELECT 飼育県 FROM 頭数集計
                  ORDER BY 頭数
                 OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY)

-- 7-3(3)
SELECT 個体識別番号,
       CASE 品種コード WHEN '01' THEN '乳用種'
                     WHEN '02' THEN '肉用種'
                     WHEN '03' THEN '交雑種'
        END AS 品種, 出生日, 母牛番号
  FROM 個体識別
 WHERE 母牛番号 IN (SELECT 個体識別番号 FROM 個体識別
                   WHERE 品種コード = '01')