-- same as migration.sql
ALTER TABLE "StoreOrder" ADD COLUMN IF NOT EXISTS "platformFeePercent" INTEGER NOT NULL DEFAULT 10;
ALTER TABLE "StoreOrder" ADD COLUMN IF NOT EXISTS "platformFeePaise" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "StoreOrder" ADD COLUMN IF NOT EXISTS "sellerNetPaise" INTEGER NOT NULL DEFAULT 0;
-- plus the UPDATE from that file if you want backfill