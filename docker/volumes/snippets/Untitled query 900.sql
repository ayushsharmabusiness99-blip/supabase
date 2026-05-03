-- Scope automation rules to a specific connected Instagram profile (UUID row id).
ALTER TABLE "AutomationRule" ADD COLUMN IF NOT EXISTS "instagramAccountId" TEXT;

-- Backfill: attach each existing rule to the user's earliest-connected Instagram account.
UPDATE "AutomationRule" AS r
SET "instagramAccountId" = (
  SELECT ia.id
  FROM "InstagramAccount" AS ia
  WHERE ia."userId" = r."userId"
  ORDER BY ia."connectedAt" ASC NULLS LAST
  LIMIT 1
)
WHERE r."instagramAccountId" IS NULL;

ALTER TABLE "AutomationRule" DROP CONSTRAINT IF EXISTS "AutomationRule_instagramAccountId_fkey";

ALTER TABLE "AutomationRule"
  ADD CONSTRAINT "AutomationRule_instagramAccountId_fkey"
  FOREIGN KEY ("instagramAccountId") REFERENCES "InstagramAccount"("id") ON DELETE CASCADE ON UPDATE CASCADE;

CREATE INDEX IF NOT EXISTS "AutomationRule_instagramAccountId_idx" ON "AutomationRule"("instagramAccountId");
