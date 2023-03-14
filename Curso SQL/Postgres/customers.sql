-- ----------------------------
--  Table: Customers
-- ----------------------------
DROP TABLE IF EXISTS "public"."customers";
CREATE TABLE "public"."customers" (
	"customer_id" int4 NOT NULL,
	"first_name" varchar(100) COLLATE "default",
	"last_name" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE);

-- ----------------------------
--  Sample customers records
-- ----------------------------
BEGIN;
INSERT INTO "public"."customers" VALUES ('1', 'John', 'Doe');
INSERT INTO "public"."customers" VALUES ('2', 'Jeff', 'Smith');
INSERT INTO "public"."customers" VALUES ('3', 'Mike', 'Steel');
INSERT INTO "public"."customers" VALUES ('4', 'Mark', 'Benjamin');
INSERT INTO "public"."customers" VALUES ('5', 'Hannah', 'Rose');
COMMIT;

-- ----------------------------
--  Primary key for table : customers
-- ----------------------------
ALTER TABLE "public"."customers" ADD PRIMARY KEY ("customer_id") NOT DEFERRABLE INITIALLY IMMEDIATE;
