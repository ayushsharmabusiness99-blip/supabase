-- =============================================================================
-- Run in Supabase: Dashboard → SQL → New query → paste → Run
-- Idempotent: safe to run again if some objects already exist.
-- =============================================================================

-- 1) Account type (Creator / Business) on User + pending registration
ALTER TABLE "User" ADD COLUMN IF NOT EXISTS "accountType" TEXT NOT NULL DEFAULT 'CREATOR';
ALTER TABLE "PendingRegistration" ADD COLUMN IF NOT EXISTS "accountType" TEXT NOT NULL DEFAULT 'CREATOR';

-- 2) Brand collaboration posts (business dashboard → Brand)
CREATE TABLE IF NOT EXISTS "BrandCollabPost" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "minFollowers" INTEGER NOT NULL DEFAULT 1000,
    "minAvgViews" INTEGER NOT NULL DEFAULT 10000,
    "imageUrl" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "BrandCollabPost_pkey" PRIMARY KEY ("id")
);

CREATE INDEX IF NOT EXISTS "BrandCollabPost_userId_idx" ON "BrandCollabPost"("userId");

DO $$
BEGIN
  ALTER TABLE "BrandCollabPost"
    ADD CONSTRAINT "BrandCollabPost_userId_fkey"
    FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;