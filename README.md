# Classroom Seating Planner

## What this is

A single-file web app (originally built with regular Claude, for Matt's wife
— a teacher) that generates classroom seating charts — table pods, rows, or
carpet dot spots — from a pasted roster, with gender-balance and swap rules.
It's fully self-contained: no backend, no accounts, no `localStorage`.
Persistence works by **downloading a small JSON file** ("Save this class")
and re-uploading it next time ("Load saved class").

This repo is the starting point for **Project 2** of a "getting comfortable
with Claude Code" arc (Project 1 was a personal health dashboard, in a
sibling repo at `~/Documents/health-dashboard`). Goal here: take this from
"a file on my Desktop" to something hosted that other teachers can actually
use, possibly for a small fee.

## Origin & requirements (from the original build conversation)

Full transcript: https://claude.ai/share/e07f3d1c-d049-4721-bd77-f0e8cb3a81d4
(built entirely in regular Claude, not Claude Code — see
[CHANGELOG.md](./CHANGELOG.md) for how it evolved from v1 to v7).

Original ask: a shareable tool (deliberately **not** a hosted app, to avoid
any server/hosting cost) to help teachers build a randomized seating chart:
set seats per table, paste a roster, add plain-English constraints (gender
balance, "keep Peter and Paul apart"), generate instantly, print/save as PDF.
A single self-contained `.html` file was chosen specifically because it needs
no login and no install — a teacher can just double-click it.

A few decisions from that conversation still shape the app and are worth
knowing before changing anything:

- **Nothing is uploaded or stored anywhere** — everything runs client-side.
  This was a deliberate choice given the tool handles student names, and is
  worth preserving if this ever grows a backend.
- **Gender tagging is a guess-then-override UI**, not a hard requirement —
  auto-guessed from a static ~300-name list, always one click to correct,
  never silently trusted.
- **Rules parsing is pattern-based, not true NLU** — a "detected rules"
  preview step exists specifically so a misread rule doesn't silently fail.
- **Behavior-level (1/2/3) tags are algorithm-only, never rendered** on the
  chart, on screen or in print — an intentional call since charts get
  posted/photographed/seen by subs and parents.
- Publishing this as a Claude Artifact hit a persistent "already
  published/shared" error the user couldn't resolve — that's the practical
  reason it's a downloaded file rather than an Artifact link, and part of
  why this Project 2 effort exists (a real static host sidesteps that
  entirely).

## Prior research: hosting & monetization (already done, don't redo)

Before this repo existed, the same conversation covered what it would take
to host this at a custom domain (e.g. `classroomplanner.com`) and charge
~$5/mo. Worth reading before making that decision rather than re-researching
it:

- **The core gap**: today there's no login, no payment check, no server at
  all — nothing stops anyone with the file from using it. Charging requires,
  at minimum, a way to take payment, verify who's paid, and gate access.
- **Three paths discussed, roughly in order of effort:**
  1. *No-code checkout* (Lemon Squeezy / Gumroad) — they're merchant of
     record (handle sales tax/VAT), host stays free/cheap (Cloudflare
     Pages / Netlify), gating is just an unlisted URL or password. Least
     dev work, weakest gating (anyone with the link can share it).
  2. *Membership/paywall platform* (Memberstack, Outseta) — real login +
     subscription checks, cancels revoke access automatically. More robust,
     but a recurring platform fee (~$24–47/mo) on top of Stripe's cut.
  3. *Full custom build* — own auth (e.g. Supabase's free tier) + Stripe
     Billing + a small serverless function checking subscription status.
     Most control, lowest recurring cost, but real development work.
- **Rough monthly costs at small scale:** domain ~$10–15/yr; static hosting
  $0–20/mo; Stripe ~2.9% + $0.30/charge (≈9% of a $5 charge); Memberstack
  ~$24–29/mo or Outseta ~$47/mo if using a paywall platform; Lemon Squeezy
  has no fixed fee but a larger ~9–10% combined cut per sale. At $5/mo,
  fixed-platform routes need roughly 6–8 subscribers just to break even on
  tooling — Lemon Squeezy's no-fixed-cost/bigger-cut tradeoff usually wins
  at very low subscriber counts.
- **Not yet addressed, worth revisiting if this goes ahead:** since the tool
  handles student names, running it as a paid product for other teachers
  (not just personal use) means it's worth having a basic privacy policy and
  terms of service — flagged in the original conversation but not written.

## Current state (as of this commit)

- `index.html` — copy of `~/Desktop/classroom-seating-planner-v7.html`,
  verified to run identically after the copy (sample seating chart generates
  and swap-by-click works). See [CHANGELOG.md](./CHANGELOG.md) for what v7
  actually contains and how it got there.
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
   path above, since payment requires knowing who's paying. See "Prior
   research: hosting & monetization" above before re-deriving any of this.
4. Cowork is a good fit for the non-code side of this once it's live:
   drafting a landing page pitch, finding/contacting other teachers or
   teacher communities, handling feedback.

## Running it locally

```bash
cd ~/Documents/classroom-seating-planner
./start.sh        # serves http://localhost:8001
```

Or just open `index.html` directly in a browser — it works standalone.
