-- 1-3(1)
SELECT * FROM 家計簿
 WHERE 入金額 = 50000

-- 1-3(2)
DELETE FROM 家計簿
 WHERE 出金額 > 4000

-- 1-3(3)
UPDATE 家計簿
   SET メモ = 'カフェラテを購入'
 WHERE 日付 = '2018-02-03'