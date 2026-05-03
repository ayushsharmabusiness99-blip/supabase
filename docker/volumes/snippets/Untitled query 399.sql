-- Create the Coupon table
CREATE TABLE IF NOT EXISTS "Coupon" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "code" TEXT UNIQUE NOT NULL,
  "discountPercent" INTEGER NOT NULL DEFAULT 0,
  "discountAmountPaise" INTEGER DEFAULT 0,
  "maxRedemptions" INTEGER DEFAULT NULL,
  "redemptions" INTEGER DEFAULT 0,
  "isActive" BOOLEAN DEFAULT true,
  "expiresAt" TIMESTAMP WITH TIME ZONE,
  "createdAt" TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Create an index for faster lookups by code
CREATE INDEX IF NOT EXISTS "idx_coupon_code" ON "Coupon"("code");

-- Grant permissions (if needed for your setup)
ALTER TABLE "Coupon" ENABLE ROW LEVEL SECURITY;
-- You may need to add specific RLS policies if you aren't using the service_role key for admin
