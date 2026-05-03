ALTER TABLE "AutomationRule" ADD COLUMN IF NOT EXISTS "dmImageUrl" TEXT;
ALTER TABLE "MessageQueue" ADD COLUMN IF NOT EXISTS "attachmentImageUrl" TEXT;
ALTER TABLE "AutomationRule" ADD COLUMN IF NOT EXISTS "followGateMessageText" TEXT;