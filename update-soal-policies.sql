-- Update Supabase Policies for soal table to allow public CRUD operations
-- Jalankan script ini di SQL Editor Supabase

-- Drop existing policies for soal table
DROP POLICY IF EXISTS "Allow authenticated users to read soal" ON soal;
DROP POLICY IF EXISTS "Allow authenticated users to insert soal" ON soal;
DROP POLICY IF EXISTS "Allow authenticated users to update soal" ON soal;
DROP POLICY IF EXISTS "Allow authenticated users to delete soal" ON soal;

-- Create new policies that allow public access (no authentication required)
-- Policy for public read access
CREATE POLICY "Allow public read access" ON soal
    FOR SELECT USING (true);

-- Policy for public insert access
CREATE POLICY "Allow public insert access" ON soal
    FOR INSERT WITH CHECK (true);

-- Policy for public update access
CREATE POLICY "Allow public update access" ON soal
    FOR UPDATE USING (true);

-- Policy for public delete access
CREATE POLICY "Allow public delete access" ON soal
    FOR DELETE USING (true);

-- Verify the policies have been updated
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual,
    with_check
FROM pg_policies 
WHERE tablename = 'soal'
ORDER BY policyname; 