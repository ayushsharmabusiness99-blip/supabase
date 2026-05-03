ALTER TABLE "Store" ADD COLUMN IF NOT EXISTS "customConfig" jsonb;
ALTER TABLE "Store" ADD COLUMN IF NOT EXISTS "facebookUrl" text;
ALTER TABLE "Store" ADD COLUMN IF NOT EXISTS "instagramUrl" text;
ALTER TABLE "Store" ADD COLUMN IF NOT EXISTS "twitterUrl" text;
ALTER TABLE "Store" ADD COLUMN IF NOT EXISTS "telegramUrl" text;
ALTER TABLE "Store" ADD COLUMN IF NOT EXISTS "metaTitle" text;
ALTER TABLE "Store" ADD COLUMN IF NOT EXISTS "metaDescription" text;
ALTER TABLE "Store" ADD COLUMN IF NOT EXISTS "isMaintenance" boolean DEFAULT false;
