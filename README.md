# கிளிஞ்சல்கள் site

Static site: `index.html` (no build step).

## Turn on comments, ratings, view counts, admin
1. Run `supabase-setup.sql` in your Supabase project (SQL Editor).
2. In `index.html` search for `SB = { url:` and put your Project URL and anon key in the two quotes:
   `SB = { url: 'https://xxxx.supabase.co', key: 'eyJ...' }`
3. Upload again. Admin page: `https://your-site/#admin`.

## Deploy
- Netlify: drag this folder onto https://app.netlify.com/drop
- GitHub Pages: push, then Settings > Pages > main / root.
