
USE placement_cell;

-- Ensure HOD is in chk_role (Done in schema update, but if not run yet)
-- ALTER TABLE users DROP CONSTRAINT chk_role;
-- ALTER TABLE users ADD CONSTRAINT chk_role CHECK (role IN ('STUDENT', 'ADMIN', 'HOD'));

-- Insert HODs
INSERT IGNORE INTO users (email, password, role, fullName, branch) VALUES 
('jaffar@sgp.com', 'jaffar123', 'HOD', 'MD Jaffar', 'Computer Science'),
('irfan@sgp.com', 'irfan123', 'HOD', 'Mr. Irfan Basha', 'Electrical & Electronics'),
('tanusha@sgp.com', 'tanusha123', 'HOD', 'Mrs. Tanusha S.M', 'Civil'),
('nagraj@sgp.com', 'nagraj123', 'HOD', 'Mr. Nagraj Hugar', 'Metallurgy'),
('sayed@sgp.com', 'sayed123', 'HOD', 'Mr. Sayed Assad Basha', 'Mechanical');
