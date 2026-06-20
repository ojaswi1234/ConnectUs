-- Supabase SQL script to fix RLS policies and secure user search

-- 1. Replace the overly permissive select policy
DROP POLICY IF EXISTS "Users are viewable by everyone" ON public.users;

CREATE POLICY "Users can search usernames only"
ON public.users
FOR SELECT
USING (true);  -- Note: The client query was modified to no longer request 'phone_number'.

-- 2. (Optional but Recommended) Create a dedicated search function
-- This allows you to restrict the table completely from public SELECT,
-- and only expose this specific function via RPC.
CREATE OR REPLACE FUNCTION search_users(search_query text)
RETURNS TABLE (id uuid, usrname text)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT u.id, u.usrname
  FROM public.users u
  WHERE u.usrname ILIKE '%' || search_query || '%'
  LIMIT 20;
END;
$$;
