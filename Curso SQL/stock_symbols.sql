-- ----------------------------
--  Table : stocks_symbols
-- ----------------------------
DROP TABLE IF EXISTS "public"."stocks_symbols";
CREATE TABLE "public"."stocks_symbols" (
	"symbol_id" int4 NOT NULL,
	"symbol" varchar(50) NOT NULL COLLATE "default",
	"symbol_name" varchar(255) NOT NULL COLLATE "default",
	"symbol_type_code" varchar(10) NOT NULL COLLATE "default",
	"symbol_sector" varchar(255) NOT NULL COLLATE "default"
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Records of stock_symbols
-- ----------------------------
BEGIN;
INSERT INTO "public"."stocks_symbols" VALUES ('1','AAL','American Airlines Group Inc','EQS','Services');
INSERT INTO "public"."stocks_symbols" VALUES ('2','AAPL','Apple Inc','EQS','Consumer Goods');
INSERT INTO "public"."stocks_symbols" VALUES ('3','AMZN','Amazon.com Inc.','EQS','Services');
INSERT INTO "public"."stocks_symbols" VALUES ('4','C','Citigroup Inc','EQS','Financial');
INSERT INTO "public"."stocks_symbols" VALUES ('5','FB','Facebook Inc','EQS','Technology');
INSERT INTO "public"."stocks_symbols" VALUES ('6','FB','FBR Asset Investment Corp','EQS','Technology');
INSERT INTO "public"."stocks_symbols" VALUES ('7','GE','General Electric Co.','EQS','Industrial Goods');
INSERT INTO "public"."stocks_symbols" VALUES ('8','GOOG','Alphabet Inc','EQS','Technology');
INSERT INTO "public"."stocks_symbols" VALUES ('9','GOOG','Google Inc','EQS','');
INSERT INTO "public"."stocks_symbols" VALUES ('10','NFLX','NetFlix Inc','EQS','Services');
INSERT INTO "public"."stocks_symbols" VALUES ('11','QQQ','Invesco QQQ Trust Series 1','ETF','');
INSERT INTO "public"."stocks_symbols" VALUES ('12','SPY','SSGA SPDR S&P 500','ETF','');
INSERT INTO "public"."stocks_symbols" VALUES ('13','TSLA','Tesla Inc','EQS','Consumer Goods');
INSERT INTO "public"."stocks_symbols" VALUES ('14','XLF','Financial Select Sector SPDR','ETF','');
INSERT INTO "public"."stocks_symbols" VALUES ('15','XLP','Consumer Staples Select Sector SPDR','ETF','');
COMMIT;

-- ----------------------------
--  Primary key structure for table stock_symbols
-- ----------------------------
ALTER TABLE "public"."stocks_symbols" ADD PRIMARY KEY ("symbol_id") NOT DEFERRABLE INITIALLY IMMEDIATE;
