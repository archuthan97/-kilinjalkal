-- Run once in Supabase > SQL Editor (safe to re-run)
-- Visit log for the admin analytics: one row when a reader opens the site (per browsing session)
-- and one row the first time they open each piece in that session. No IP address or personal data:
-- vid is the random id the site already keeps in the browser for ratings.

create table if not exists visits (
  id bigint generated always as identity primary key,
  piece text not null check (char_length(piece) <= 40),   -- 'site', p12, s3, d5, n7 ...
  vid text check (char_length(vid) <= 40),                 -- random browser id
  ref text check (char_length(ref) <= 100),                -- where they came from (site visits only), e.g. l.facebook.com
  dev text check (dev in ('m', 'd')),                      -- m = phone, d = computer
  created_at timestamptz not null default now()
);
create index if not exists visits_created_at on visits (created_at);

alter table visits enable row level security;

-- readers can only add rows; only you (logged in) can read them
drop policy if exists "visits add" on visits;
create policy "visits add" on visits for insert to anon, authenticated with check (true);
drop policy if exists "visits admin read" on visits;
create policy "visits admin read" on visits for select to authenticated using (true);
