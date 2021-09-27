--34
SELECT 口座番号, 残高 / 1000 AS 千円単位の残高
  FROM 口座
 WHERE 残高 >= 1000000

--35
INSERT INTO 口座(口座番号, 名義, 種別, 残高, 更新日)
     VALUES ('0652281', 'タカギ　ノブオ', '1', 100000 + 3000, '2018-04-01')
INSERT INTO 口座(口座番号, 名義, 種別, 残高, 更新日)
     VALUES ('1026413', 'マツモト　サワコ', '1', 300000 + 3000, '2018-04-02')
INSERT INTO 口座(口座番号, 名義, 種別, 残高, 更新日)
     VALUES ('2239710', 'ササキ　シゲノリ', '1', 1000000 + 3000, '2018-04-03')

--36
UPDATE 口座
   SET 残高 = (残高 - 3000) * 1.003
 WHERE 口座 IN ('0652281', '1026413', '2239710')

--37
SELECT 口座番号, 更新日,
       更新日 + 180 AS 通帳期限日
  FROM 口座
 WHERE 更新日 < '2017-01-01'

--38
SELECT 口座番号, CONCAT('）カ', 名義) AS 名義
-- SELECT 口座番号, 'カ）' || 名義 AS 名義
  FROM 口座
 WHERE 種別 = '3'

--39
SELECT DISTINCT 種別 AS 種別コード,
  CASE 種別 WHEN '1' THEN '普通'
           WHEN '2' THEN '当座'
           WHEN '3' THEN '別段' END AS 種別名
  FROM 口座

--40
SELECT 口座番号, 名義,
　CASE WHEN 残高 < 100000 THEN 'C'
       WHEN 残高 >= 100000 AND 残高 < 1000000 THEN 'B'
       WHEN 残高 > 1000000 THEN 'A' END AS 残高ランク
  FROM 口座

--41
SELECT LENGTH(口座番号), LENGTH(TRIM(名義)),
       LENGTH(CAST(残高 AS VARCHAR))
  FROM 口座
-- SELECT LENGTH(口座番号), LENGTH(REPLACE(名義, '　', '')),
--        LENGTH(CAST(残高 AS VARCHAR))
--   FROM 口座

--42
SELECT * FROM 口座
 WHERE SUBSTRING(名義, 1, 5) LIKE '%カワ%'

--43
SELECT * FROM 口座
 WHERE LENGTH(CAST(残高 AS VARCHAR)) >= 4 AND
       SUBSTRING(CAST(残高 AS VARCHAR), LENGTH(CAST(残高 AS VARCHAR))-2, 3) = '000'
--  3行目解けなかった

--44
SELECT 口座番号, 残高,
       TRUNK(残高 * 0.002, 0) AS 利息
  FROM 口座
 ORDER BY 残高 DESC

--45
SELECT 口座番号, 残高,
  CASE WHEN 残高 < 500000 THEN TRUNK(残高 * 0.001, 0)
       WHEN 残高 >= 500000 AND 残高 < 2000000 THEN TRUNK(残高 * 0.002, 0)
       WHEN 残高 >= 2000000 THEN TRUNK(残高 * 0.003, 0) END AS 残高別利息
  FROM 口座
 ORDER BY 残高別利息 DESC, 口座番号

--46
INSERT INTO 口座(口座番号, 名義, 種別, 残高, 更新日)
     VALUES ('0351262', 'イトカワ　ダイ', '2', 635110, CURRENT_DATE)
INSERT INTO 口座(口座番号, 名義, 種別, 残高, 更新日)
     VALUES ('1015513', 'アキツ　ジュンジ', '1', 88463, CURRENT_DATE)
INSERT INTO 口座(口座番号, 名義, 種別, 残高, 更新日)
     VALUES ('2239710', 'ホシノ　サトミ', '1', 704610, CURRENT_DATE)

--47
SELECT REPLACE(更新日, ) AS 更新日  --SUBSTRINGで一部を抽出する
  FROM 口座
 WHERE 更新日 >= '2018-01-01'
--解けなかった
-- SELECT 口座番号, 名義, 種別, 残高,
--        SUBSTRING(CAST(更新日 AS VARCHAR), 1, 4) || '年' ||
-- 	      SUBSTRING(CAST(更新日 AS VARCHAR), 6, 2) || '月' ||
-- 	      SUBSTRING(CAST(更新日 AS VARCHAR), 9, 2) || '日' AS 更新日
--   FROM 口座
--  WHERE 更新日 >= '2018-01-01'


--48
SELECT COALESCE(更新日, '設定なし')  --CASTしてからCOALESCEしないといけない
  FROM 口座
-- SELECT COALESCE(CAST(更新日 AS VARCHAR), '設定なし') AS 更新日
--   FROM 口座