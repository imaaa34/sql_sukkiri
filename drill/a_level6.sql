--59
UPDATE 口座
   SET 残高 = (SELECT COALESCE(SUM(入金額) - SUM(出金額), 0)
                FROM 取引
               WHERE 口座番号 = '0351333' AND 取引日 = '2018-01-11'),
       更新日 = '2018-01-11'
 WHERE 口座番号 = '0351333'

--60
-- SELECT 残高,
--        (SELECT SUM(入金額) AS 入金額合計, SUM(出金額) AS 出金額合計
--           FROM 取引
--          WHERE 口座番号 = '1115600' AND 取引日 = '2017-12-28')
--   FROM 口座
--  WHERE 口座番号 = '1115600'
SELECT 残高,
       (SELECT SUM(入金額)
          FROM 取引
         WHERE 口座番号 = '1115600' AND 日付 = '2017-12-28') AS 入金額合計,
       (SELECT SUM(出金額)
          FROM 取引
         WHERE 口座番号 = '1115600' AND 日付 = '2017-12-28') AS 出金額合計
  FROM 口座
 WHERE 口座番号 = '1115600'

--61
SELECT 口座番号, 名義, 残高
  FROM 口座
 WHERE 口座番号 IN (SELECT 口座番号
                    FROM 取引
                   WHERE 入金額 >= 10000000)

--62
SELECT * FROM 口座
 WHERE 更新日 > ALL (SELECT 日付 FROM 取引)

--63
-- SELECT 日付, MAX(入金額), MAX(出金額)
--   FROM (SELECT * FROM 取引
--          WHERE 入金額 IS NOT NULL && 出金額 IS NOT NULL)
--  WHERE 口座番号 = '3104451'
 SELECT A. 日付,
       (SELECT MAX(入金額) FROM 取引 WHERE 口座番号 = '3104451') AS 最大入金額,
       (SELECT MAX(出金額) FROM 取引 WHERE 口座番号 = '3104451') AS 最大出金額
  FROM (SELECT 日付
          FROM 取引
         WHERE 口座番号 = '3104451'
         GROUP BY 日付
        HAVING SUM(入金額) > 0 AND SUM(出金額) > 0) AS A

--64
INSERT INTO 廃止口座
SELECT * FROM 口座
 WHERE 口座番号 = '2761055';
DELETE FROM 口座
 WHERE 口座番号 = '2761055';