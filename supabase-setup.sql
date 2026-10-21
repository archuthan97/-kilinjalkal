-- Run once in Supabase: SQL Editor > New query > paste > Run

create table comments (
  id bigint generated always as identity primary key,
  piece text not null,            -- e.g. p12, s3, d5
  name text not null check (char_length(name) between 1 and 60),
  body text not null check (char_length(body) between 1 and 1000),
  approved boolean not null default true,
  created_at timestamptz not null default now()
);
create table ratings (
  id bigint generated always as identity primary key,
  piece text not null,
  stars int not null check (stars between 1 and 5),
  visitor text not null,          -- random id stored in the browser, one vote per piece
  unique (piece, visitor)
);
create table views (
  piece text primary key,
  n bigint not null default 0
);
create table added_pieces (       -- new items you add from the admin page
  id bigint generated always as identity primary key,
  section text not null,          -- poems / stories / kirukkal
  title text not null,
  body text not null,
  title_en text, body_en text,
  created_at timestamptz not null default now()
);

alter table comments enable row level security;
alter table ratings enable row level security;
alter table views enable row level security;
alter table added_pieces enable row level security;

-- everyone can read; visitors can add comments and ratings
create policy "read comments" on comments for select using (approved);
create policy "add comments" on comments for insert with check (true);
create policy "read ratings" on ratings for select using (true);
create policy "add ratings" on ratings for insert with check (true);
create policy "change own rating" on ratings for update using (true) with check (true);
create policy "read views" on views for select using (true);
create policy "read added" on added_pieces for select using (true);

-- only you (logged-in) can moderate and add pieces
create policy "admin comments" on comments for all to authenticated using (true) with check (true);
create policy "admin added" on added_pieces for all to authenticated using (true) with check (true);

-- view counter (safe increment)
create function bump_view(p text) returns bigint language sql security definer as $$
  insert into views(piece,n) values (p,1)
  on conflict (piece) do update set n = views.n + 1
  returning n;
$$;
grant execute on function bump_view(text) to anon, authenticated;
