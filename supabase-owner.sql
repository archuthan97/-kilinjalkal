-- Applied 2026-10-22 (safe to re-run). Only the site owner's account gets admin rights,
-- not every signed-in account. The uuid is the owner's Supabase Auth user id (not a secret).
create or replace function public.is_owner() returns boolean
  language sql stable security invoker set search_path = ''
  as $$ select (select auth.uid()) = '0e3686cf-4ba9-4023-b816-753265ce0b81'::uuid $$;

drop policy if exists "admin added" on public.added_pieces;
create policy "admin added" on public.added_pieces for all to authenticated using (public.is_owner()) with check (public.is_owner());
drop policy if exists "pieces admin update" on public.added_pieces;
create policy "pieces admin update" on public.added_pieces for update to authenticated using (public.is_owner()) with check (public.is_owner());
drop policy if exists "pieces admin delete" on public.added_pieces;
create policy "pieces admin delete" on public.added_pieces for delete to authenticated using (public.is_owner());

drop policy if exists "admin comments" on public.comments;
create policy "admin comments" on public.comments for all to authenticated using (public.is_owner()) with check (public.is_owner());

drop policy if exists "sections admin insert" on public.sections;
create policy "sections admin insert" on public.sections for insert to authenticated with check (public.is_owner());
drop policy if exists "sections admin delete" on public.sections;
create policy "sections admin delete" on public.sections for delete to authenticated using (public.is_owner());

drop policy if exists "visits admin read" on public.visits;
create policy "visits admin read" on public.visits for select to authenticated using (public.is_owner());

-- harden the public visit counter (it stays public on purpose)
alter function public.bump_view(text) set search_path = public;
