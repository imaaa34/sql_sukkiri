--49
SELECT SUM(残高) AS 合計, MAX(残高) AS 最大, MIN(残高) AS 最小,
       AVG(残高) AS 平均, COUNT(*) AS 件数
  FROM 口座

--50
SELECT COUNT(*) AS 件数 FROM 口座
 WHERE 種別 <> '1' AND 残高 >= 1000000 AND 更新日 < '2018-01-01'

--51
-- SELECT COUNT(*) AS 件数 FROM 口座
--  WHERE 口座番号 IS NULL
SELECT COUNT(*) - COUNT(更新日) AS 更新日が登録されていない件数
  FROM 口座

--52
SELECT MAX(名義), MIN(名義) FROM 口座

--53
SELECT MAX(更新日), MIN(更新日) FROM 口座

--54
SELECT 種別, SUM(残高) AS 合計, MAX(残高) AS 最大,
       MIN(残高) AS 最小, AVG(残高) AS 平均, COUNT(*) 件数
  FROM 口座
 GROUP BY 種別

--55
-- SELECT COUNT(*) FROM 口座
--  GROUP BY SUBSTRING(口座番号, 7, 1)
--  ORDER BY COUNT(*)
SELECT SUBSTRING(口座番号, 7, 1) AS 口座番号グループ, COUNT(*) AS 件数
  FROM 口座
 GROUP BY SUBSTRING(口座番号, 7, 1)
 ORDER BY COUNT(*) DESC

--56
-- SELECT SUM(残高) AS 合計, MAX(残高) AS 最大, MIN(残高) AS 最小, AVG(残高) AS 平均, COUNT(*) 件数
--   FROM 口座
--  GROUP BY COALESCE(SUBSTRING(更新日, 1, 4) || '年', 'XXXX年')
SELECT SUBSTRING(COALESCE(CAST(更新日 AS VARCHAR), 'XXXX'), 1, 4) AS 更新年,
       SUM(残高) AS 合計, MAX(残高) AS 最大, MIN(残高) AS 最小, AVG(残高) AS 平均, COUNT(*) 件数
  FROM 口座
 GROUP BY SUBSTRING(COALESCE(CAST(更新日 AS VARCHAR), 'XXXX'), 1, 4)
--CASTでデータ型変更してからCOALESCEでNULL埋めてSUBSTRINGで4桁に統一

--57
SELECT 種別, SUM(残高) AS 合計, COUNT(*) AS 件数 FROM 口座
 GROUP BY 種別
HAVING SUM(残高) > 3000000

--58
SELECT SUBSTRING(名義, 1, 1) AS 名義, COUNT(名義) AS 件数,
       AVG(LENGTH(REPLACE(名義, '　', ''))) AS 文字数の平均
  FROM 口座
 GROUP BY SUBSTRING(名義, 1, 1)
HAVING COUNT(名義) >= 10 OR AVG(LENGTH(REPLACE(名義, '　', ''))) > 5