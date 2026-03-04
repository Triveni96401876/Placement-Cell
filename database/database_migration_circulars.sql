-- Migration script to add title and file_path columns to circulars table
-- Run this script on your existing database

USE placement_cell;

-- Add title column if it doesn't exist
ALTER TABLE circulars 
ADD COLUMN IF NOT EXISTS title VARCHAR(255) DEFAULT 'Important Update' AFTER id;

-- Add file_path column if it doesn't exist
ALTER TABLE circulars 
ADD COLUMN IF NOT EXISTS file_path VARCHAR(500) DEFAULT NULL AFTER message;

-- Update existing records to have a default title
UPDATE circulars SET title = 'Important Update' WHERE title IS NULL OR title = '';

-- Display updated structure
DESCRIBE circulars;

-- Show sample data
SELECT id, title, LEFT(message, 50) as message_preview, file_path, is_active, created_at 
FROM circulars 
ORDER BY created_at DESC 
LIMIT 5;
