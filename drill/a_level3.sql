--24
SELECT * FROM 口座
 ORDER BY 口座番号

--25
SELECT DISTINCT 名義 FROM 口座
 ORDER BY 名義

--26
SELECT * FROM 口座
 ORDER BY 4 DESC, 1

--27
SELECT 更新日 FROM 口座
 WHERE 更新日 IS NOT NULL
 ORDER BY 更新日
OFFSET 0 ROWS
 FETCH NEXT 10 ROWS ONLY

--28
SELECT 更新日, 残高 FROM 口座
 WHERE 残高 > 0 AND 更新日 IS NOT NULL
 ORDER BY 残高, 更新日 DESC
-- OFFSET 11 ROWS
--  FETCH NEXT 9 ROWS ONLY
OFFSET 10 ROWS
 FETCH NEXT 10 ROWS ONLY

 --29
SELECT 口座番号 FROM 口座
 UNION
SELECT 口座番号 FROM 廃止口座
 ORDER BY 口座番号

--30
SELECT 名義 FROM 口座
EXCEPT
SELECT 名義 FROM 廃止口座
--  ORDER BY DISTINCT 名義 DESC
 ORDER BY 1 DESC --重複したデータを除き降順に並べる

--31
SELECT 名義 FROM 口座
INTERSECT
SELECT 名義 FROM 廃止口座
 ORDER BY 1

--32
SELECT 口座番号, 残高 FROM 口座
 WHERE 残高 = 0
 UNION
SELECT 口座番号, 解約時残高 FROM 廃止口座
 WHERE 解約時残高 <> 0
 ORDER BY 口座番号

--33
-- SELECT 口座番号, 名義 FROM 口座
--  UNION
-- SELECT 口座番号, 名義 FROM 廃止口座
--  ORDER BY 名義
SELECT 口座番号, 名義, '◯' AS 口座区分 FROM 口座
 UNION
SELECT 口座番号, 名義, '×' AS 口座区分 FROM 廃止口座
 ORDER BY 名義