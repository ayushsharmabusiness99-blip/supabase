-- 1. Add the missing digital asset column
ALTER TABLE "Product" ADD COLUMN IF NOT EXISTS "assetUrl" text;

-- 2. Increase the storage bucket limit to 1.5 GB
UPDATE storage.buckets 
SET file_size_limit = 1610612736 
WHERE id = 'store-assets';

-- 3. Refresh the API cache so it sees the new column
NOTIFY pgrst, 'reload schema';
