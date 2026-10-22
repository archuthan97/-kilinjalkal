# கிளிஞ்சல்கள் site (kilinjalkal.netlify.app)

Static site: `index.html` (HTML + CSS + vanilla JS, no build step, ~730 KB because poems/stories are embedded) plus photos in `img/` (cover, banner, beach; `img/banner.jpg` is also the link-preview image).
Hosted on Netlify (auto-deploys from the `main` branch). Backend: Supabase (comments, ratings, view counts, `#admin` login, added pieces, custom tabs).

## Rules
- Edit `index.html` directly. Never rewrite the whole file; use targeted edits (grep for the function or CSS class first). The large embedded data lines (POEMS, STORIES, DIARY, KIR, SYN) must not be touched or reformatted. Photos live in `img/`, not as base64 in the page.
- Do not remove or change `SB = { url, key }`. The publishable key is public by design. Never add the Supabase secret/service key anywhere.
- Content is Tamil; keep fonts, `lang` attributes and the existing design tokens (--ink, --paper, --accent, etc.). Mobile first: test at 390px width, no horizontal scroll.
- Social features (comments, ratings, counters, admin) only work on the live Netlify site, not when opened as a local file with network blocked.
- Locked diary chapter 18 is encrypted (AES-GCM, passcode `hanoi`); do not alter the `enc` data.
- Full English translations live in `en/<key>.json` (`{t, b, note?, checked?}`, `b` mirrors the Tamil structure) and load only when a reader picks English in the தமிழ் | English switch. They are AI translations, labelled as such; set `"checked": true` once the author has reviewed one. `en/d18.json` is encrypted with the same passcode as chapter 18 and opens only after that chapter is unlocked. Do not quote song lyrics in translations; describe them.
- New writing and new tabs are added by the owner in `#admin`, not in code. SQL schema is in `supabase-setup.sql`, `supabase-update.sql` and `supabase-analytics.sql` (the `visits` log behind the admin analytics). The owner reaches `#admin` from the lock icon in the footer.
- Key functions: `header()`, `home()`, `tabs()`, `loadAdded()` (cached in localStorage `kj-cache`), `adminPage()`, `newRead()`, `socialBox()`, `render()`.

## Workflow
Make the change, check it in a browser at phone width, commit to `main` with a clear message, push. Netlify deploys automatically in ~30 seconds.
