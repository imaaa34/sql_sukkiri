--9
SELECT * FROM 口座
 WHERE 口座番号 = '0037651'

--10
SELECT * FROM 口座
 WHERE 残高 > 0

--11
SELECT * FROM 口座
 WHERE 口座番号 < '1000000'

--12
SELECT * FROM 口座
--  WHERE 更新日 < 2017
 WHERE 更新日 < '2018-01-01'

--13
SELECT * FROM 口座
 WHERE 残高 >= 1000000

--14
SELECT * FROM 口座
--  WHERE NOT 種別 = '1'
 WHERE 種別 <> '1'

--15
SELECT * FROM 口座
 WHERE 更新日 IS NULL

--16
SELECT * FROM 口座
 WHERE 名義 LIKE '%ハシ%'

--17
SELECT * FROM 口座
 WHERE 更新日 BETWEEN '2018-01-01' AND '2018-01-31'

--18
SELECT * FROM 口座
--  WHERE 種別 = '2' OR 種別 = '3'
 WHERE 種別 IN ('2', '3')

--19
SELECT * FROM 口座
--  WHERE 名義 = 'サカタ　リョウヘイ' OR 名義 = 'マツモト　ミワコ' OR 名義 = 'ハマダ　サトシ'
 WHERE 名義 IN ('サカタ　リョウヘイ', 'マツモト　ミワコ', 'ハマダ　サトシ')

--20
SELECT * FROM 口座
--  WHERE 更新日 BETWEEN '2017-12-30' AND '2018-01-04'
 WHERE 更新日 >= '2017-12-30'
   AND 更新日 < '2018-01-05'

--21
SELECT * FROM 口座
 WHERE 残高 < 10000 AND 更新日 IS NOT NULL

--22
SELECT * FROM 口座
--  WHERE 口座番号 BETWEEN '2000000' AND '2999999' OR
--        名義 LIKE 'エ%コ'
 WHERE 口座番号 LIKE '2______'
    OR 名義 LIKE 'エ__　%コ'