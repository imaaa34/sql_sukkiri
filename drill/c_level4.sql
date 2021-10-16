--33
SELECT 名称 AS なまえ, HP AS 現在のHP, HP + 50 AS 装備後のHP
  FROM パーティー
 WHERE 職業コード IN ('11', '21')

--34
UPDATE パーティー
   SET MP = MP + 20
 WHERE ID IN ('A01', 'A03')

--35
SELECT 名称 AS なまえ, HP AS 現在のHP, HP * 2 AS 予想されるダメージ
  FROM パーティー
 WHERE 職業コード = '11'

--36
SELECT 名称 AS なまえ, HP || '/' || MP AS HPとMP,
  CASE 状態コード WHEN '00' THEN NULL
                WHEN '01' THEN '眠り'
                WHEN '02' THEN '毒'
                WHEN '03' THEN '沈黙'
                WHEN '04' THEN '混乱'
                WHEN '09' THEN '気絶'
   END AS ステータス
  FROM パーティー

--37
SELECT イベント番号, イベント名称,
  CASE タイプ WHEN '1' THEN '強制'
             WHEN '2' THEN 'フリー'
             WHEN '3' THEN '特殊'
   END AS タイプ,
  CASE WHEN イベント番号 BETWEEN 1 AND 10 THEN '序盤'
       WHEN イベント番号 BETWEEN 11 AND 17 THEN '中盤'
       ELSE '終盤'
   END AS 発生時期
　FROM イベント

--38
SELECT 名称 AS なまえ, HP AS 現在のHP, LENGTH(名称) * 10 AS 予想ダメージ
  FROM パーティー

--39
UPDATE パーティー
   SET 状態コード = '04'
 WHERE (HP % 4 == 0) OR (MP % 4 == 0)
--  WHERE MOD(HP, 4) = 0 OR MOD(MP, 4) = 0

--40
SELECT TRUNC(777 * 0.7, 0) AS 支払った金額

--41
UPDATE パーティー
  SET HP = ROUND(HP * 1.3, 0),
      MP = ROUND(MP * 1.3, 0)

--42
SELECT 名称 AS なまえ, HP,
       POWER(HP, 0) AS 攻撃1回目,
       POWER(HP, 1) AS 攻撃2回目,
       POWER(HP, 2) AS 攻撃3回目
  FROM パーティー
 WHERE 職業コード = '10'

--43
SELECT 名称 AS なまえ, HP, 状態コード,
  CASE WHEN HP <= 50 THEN CAST(状態コード AS INTEGER) + 3
       WHEN HP >= 51 AND HP <= 100 THEN CAST(状態コード AS INTEGER) + 2
       WHEN HP >= 101 AND HP <= 150 THEN CAST(状態コード AS INTEGER) + 1
       ELSE CAST(状態コード AS INTEGER)
   END AS リスク値
  FROM パーティー
 ORDER BY リスク値 DESC, HP

--44
-- SELECT COALESCE(前提イベント番号, '前提なし'), イベント番号,
--        COALESCE(後続イベント番号, '後続なし')
--   FROM イベント
--  ORDER BY イベント番号
SELECT COALESCE(CAST(前提イベント番号 AS VARCHAR), '前提なし'), イベント番号,
       COALESCE(CAST(後続イベント番号 AS VARCHAR), '後続なし')
  FROM イベント
 ORDER BY イベント番号
--INTEGERに'前提なし'という文字列を入れられないのでCASTする必要がある