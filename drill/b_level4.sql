--34
SELECT 商品コード, 単価, 単価 * 0.95 AS キャンペーン価格
  FROM 商品
 WHERE 商品区分 = '9'
 ORDER BY 商品コード

--35

--36