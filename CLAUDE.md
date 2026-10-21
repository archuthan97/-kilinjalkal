# கிளிஞ்சல்கள் site (kilinjalkal.netlify.app)

Single-file static site: `index.html` (HTML + CSS + vanilla JS, no build step, ~800 KB because poems/stories/images are embedded).
Hosted on Netlify (auto-deploys from the `main` branch). Backend: Supabase (comments, ratings, view counts, `#admin` login, added pieces, custom tabs).

## Rules
- Edit `index.html` directly. Never rewrite the whole file; use targeted edits (grep for the function or CSS class first). The large embedded data lines (POEMS, STORIES, DIARY, KIR, SYN, images) must not be touched or reformatted.
- Do not remove or change `SB = { url, key }`. The publishable key is public by design. Never add the Supabase secret/service key anywhere.
- Content is Tamil; keep fonts, `lang` attributes and the existing design tokens (--ink, --paper, --accent, etc.). Mobile first: test at 390px width, no horizontal scroll.
- Social features (comments, ratings, counters, admin) only work on the live Netlify site, not when opened as a local file with network blocked.
- Locked diary chapter 18 is encrypted (AES-GCM, passcode `hanoi`); do not alter the `enc` data.
- New writing and new tabs are added by the owner in `#admin`, not in code. SQL schema is in `supabase-setup.sql` and `supabase-update.sql`.
- Key functions: `header()`, `home()`, `tabs()`, `loadAdded()` (cached in localStorage `kj-cache`), `adminPage()`, `newRead()`, `socialBox()`, `render()`.

## Workflow
Make the change, check it in a browser at phone width, commit to `main` with a clear message, push. Netlify deploys automatically in ~30 seconds.
