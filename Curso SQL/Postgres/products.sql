-- ----------------------------
--  Table : products
-- ----------------------------
DROP TABLE IF EXISTS "public"."products";
CREATE TABLE "public"."products" (
	"product_id" int4 NOT NULL,
	"product_name" varchar(255) NOT NULL COLLATE "default",
	"unit_price" numeric(10,2)
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Records of products
-- ----------------------------
BEGIN;
INSERT INTO "public"."products" VALUES ('1','Computer','500.00');
INSERT INTO "public"."products" VALUES ('2', 'Mouse', '20.00');
INSERT INTO "public"."products" VALUES ('3', 'Printer', '300.00');
INSERT INTO "public"."products" VALUES ('4', 'Monitor', '200.00');
INSERT INTO "public"."products" VALUES ('5', 'Microphone', '215.00');
INSERT INTO "public"."products" VALUES ('6', 'Laptop', '800.00');
COMMIT;

-- ----------------------------
--  Primary key structure for table products
-- ----------------------------
ALTER TABLE "public"."products" ADD PRIMARY KEY ("product_id") NOT DEFERRABLE INITIALLY IMMEDIATE;
