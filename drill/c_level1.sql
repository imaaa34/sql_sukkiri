--1
SELECT ID, 名称, 職業コード, HP, MP, 状態コード
  FROM パーティー

--2
SELECT 名称 AS なまえ, HP AS 現在のHP, MP AS 現在のMP
  FROM パーティー

--3
SELECT * FROM イベント

--4
SELECT イベント番号 AS 番号, イベント名称 AS 場面
  FROM イベント

--5
INSERT INTO パーティー
VALUES ('A01', 'スガワラ', '21', 131, 232, '03');

INSERT INTO パーティー
VALUES ('A02', 'オーエ', '10', 156, 84, '00');

INSERT INTO パーティー
VALUES ('A03', 'イズミ', '20', 84, 190, '00');