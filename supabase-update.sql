-- Run once in Supabase > SQL Editor (safe to re-run)
alter table added_pieces add column if not exists icon text;

create table if not exists sections (
  key text primary key,
  title text not null,
  title_en text,
  icon text,
  created_at timestamptz default now()
);
alter table sections enable row level security;

drop policy if exists "sections read" on sections;
create policy "sections read" on sections for select using (true);
drop policy if exists "sections admin insert" on sections;
create policy "sections admin insert" on sections for insert to authenticated with check (true);
drop policy if exists "sections admin delete" on sections;
create policy "sections admin delete" on sections for delete to authenticated using (true);

-- allow the owner (logged-in) to edit and delete pieces
drop policy if exists "pieces admin update" on added_pieces;
create policy "pieces admin update" on added_pieces for update to authenticated using (true) with check (true);
drop policy if exists "pieces admin delete" on added_pieces;
create policy "pieces admin delete" on added_pieces for delete to authenticated using (true);

-- site-wide visitor counter row
insert into views (piece, n) values ('site', 0) on conflict (piece) do nothing;
