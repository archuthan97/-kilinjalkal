-- Run once in Supabase > SQL Editor (safe to re-run)
-- Lets the author like a comment and write a reply under it from the site (while logged in).

alter table comments add column if not exists liked boolean not null default false;
alter table comments add column if not exists reply text check (char_length(reply) <= 1000);
alter table comments add column if not exists replied_at timestamptz;

-- visitors may still add comments, but cannot pretend to be the author
drop policy if exists "add comments" on comments;
create policy "add comments" on comments for insert to anon, authenticated
  with check (liked = false and reply is null and replied_at is null);
