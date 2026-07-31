# Classroom Seating Planner

## What this is

A single-file web app (originally built with regular Claude for a teacher)
that generates classroom seating charts — table pods, rows, or carpet dot
spots — from a pasted roster, with gender-balance and swap rules. It's fully
self-contained: no backend, no accounts, no `localStorage`. Persistence works
by **downloading a small JSON file** ("Save this class") and re-uploading it
next time ("Load saved class").

This repo is the starting point for **Project 2** of a "getting comfortable
with Claude Code" arc (Project 1 was a personal health dashboard, in a
sibling repo at `~/Documents/health-dashboard`). Goal here: take this from
"a file on my Desktop" to something hosted that other teachers can actually
use, possibly for a small fee.

## Current state (as of this commit)

- `index.html` — copy of `~/Desktop/classroom-seating-planner-v7.html`,
  verified to run identically after the copy (sample seating chart generates
  and swap-by-click works).
- `start.sh` — local server wrapper, same pattern as the health-dashboard
  project. Not strictly required yet since this app has no `fetch()` calls
  and works fine via `file://`, but will matter once anything needs a real
  origin (e.g. a backend API).
- Nothing has been deployed anywhere yet. Nothing beyond the original
  functionality has been changed.

## The plan from here (see also `~/.claude/plans/i-just-upgraded-to-cozy-lark.md`)

1. **Deploy as-is first.** Push this repo to a static host (Vercel, Netlify,
   or Cloudflare Pages all work for a single static HTML file — no build
   step needed). Get a live URL before changing any functionality. This
   alone lets other teachers try it.
2. **Decide what "scaling" actually means before adding complexity.** Two
   very different paths, and the app's current design (no backend at all)
   means neither is required yet:
   - *Stays static*: teachers keep using the existing download/upload-a-file
     model to save their class between visits. Zero new infrastructure.
   - *Needs an account system*: only necessary if teachers want their class
     saved automatically instead of managing a file, or want to access it
     from multiple devices. This requires a real backend + auth + a
     database — a substantial jump, don't default into it.
3. **Monetization is a separate, deliberate decision** — only tackle this if
   Matt actually wants the business overhead (pricing, Stripe integration,
   terms of service). It pairs naturally with the "needs an account system"
   path above, since payment requires knowing who's paying.
4. Cowork is a good fit for the non-code side of this once it's live:
   drafting a landing page pitch, finding/contacting other teachers or
   teacher communities, handling feedback.

## Running it locally

```bash
cd ~/Documents/classroom-seating-planner
./start.sh        # serves http://localhost:8001
```

Or just open `index.html` directly in a browser — it works standalone.
