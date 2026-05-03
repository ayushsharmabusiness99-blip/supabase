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

-- 3) Collab chat (creator ↔ brand per brief)
CREATE TABLE IF NOT EXISTS "CollabThread" (
    "id" TEXT NOT NULL,
    "postId" TEXT NOT NULL,
    "brandUserId" TEXT NOT NULL,
    "creatorUserId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "CollabThread_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX IF NOT EXISTS "CollabThread_postId_creatorUserId_key" ON "CollabThread"("postId", "creatorUserId");
CREATE INDEX IF NOT EXISTS "CollabThread_brandUserId_idx" ON "CollabThread"("brandUserId");
CREATE INDEX IF NOT EXISTS "CollabThread_creatorUserId_idx" ON "CollabThread"("creatorUserId");

DO $$
BEGIN
  ALTER TABLE "CollabThread"
    ADD CONSTRAINT "CollabThread_postId_fkey"
    FOREIGN KEY ("postId") REFERENCES "BrandCollabPost"("id") ON DELETE CASCADE ON UPDATE CASCADE;
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;

DO $$
BEGIN
  ALTER TABLE "CollabThread"
    ADD CONSTRAINT "CollabThread_brandUserId_fkey"
    FOREIGN KEY ("brandUserId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;

DO $$
BEGIN
  ALTER TABLE "CollabThread"
    ADD CONSTRAINT "CollabThread_creatorUserId_fkey"
    FOREIGN KEY ("creatorUserId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;

CREATE TABLE IF NOT EXISTS "CollabMessage" (
    "id" TEXT NOT NULL,
    "threadId" TEXT NOT NULL,
    "senderUserId" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "CollabMessage_pkey" PRIMARY KEY ("id")
);

CREATE INDEX IF NOT EXISTS "CollabMessage_threadId_idx" ON "CollabMessage"("threadId");

DO $$
BEGIN
  ALTER TABLE "CollabMessage"
    ADD CONSTRAINT "CollabMessage_threadId_fkey"
    FOREIGN KEY ("threadId") REFERENCES "CollabThread"("id") ON DELETE CASCADE ON UPDATE CASCADE;
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;

DO $$
BEGIN
  ALTER TABLE "CollabMessage"
    ADD CONSTRAINT "CollabMessage_senderUserId_fkey"
    FOREIGN KEY ("senderUserId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;

-- =============================================================================
-- Optional: reload PostgREST schema (usually not needed; API picks up in ~seconds)
-- In Supabase: Settings → API → sometimes pause/resume project if columns 404.
-- =============================================================================
