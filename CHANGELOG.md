# Changelog

Version history of the Classroom Seating Planner, reconstructed from the
original build conversation (regular Claude, not Claude Code):
https://claude.ai/share/e07f3d1c-d049-4721-bd77-f0e8cb3a81d4

> **Everything before v7 exists only in that conversation, not in this
> repo.** v1 through v6 were built and iterated on entirely inside Claude
> chat (as downloadable artifacts), with no local files or git history kept
> along the way. `index.html` in this repo is v7, copied over from
> `~/Desktop/classroom-seating-planner-v7.html`, and is the first version
> tracked by git. Everything below v7 is a description of what those
> artifacts contained, for historical context — not something you can check
> out.

Also worth knowing: the tool went through two name/identity changes before
settling. It started as **"Seating chart generator"**, gained a sibling
**"Dot spot generator"** app, and the two were merged at v4 under the name
**"Classroom Seating Planner"** — the name the app still uses today.

## v7 — 2026-07-30 (current, in this repo)

- Table pods view now renders in mirrored rows matching a real classroom
  layout (e.g. Table 3, 2, 1 on top; Table 6, 5, 4 below) via a new
  "Tables per row" setting (default 3), instead of a flat left-to-right list.
- Dot spot grid default changed from 5×6 (30) to 4×6 (24).
- "Run a sample seating chart" button moved from the bottom of the page to
  the top-right of the header, so it's visible without scrolling.
- Sample roster standardized to 24 students across all three views (6×4
  pods, 4×6 rows, 4×6 dots), so the demo is consistent no matter which tab
  you start on.
- `podsPerRow` is now included in the save/load class file.

## v6 — 2026-07-30

- Added click-to-swap: click a seat/dot, click another, they trade places
  (chosen over drag-and-drop for reliability across mouse/trackpad/touch).
- Each of the three views (pods/rows/dots) keeps its own manually-edited
  arrangement independently.
- Save/load now captures the actual seating arrangement (matched by student
  name, not internal ID) — loading a saved class restores exactly where
  everyone was sitting, including manual moves, instead of reshuffling.
- Manual swaps intentionally aren't rule-checked — placing a student
  somewhere that breaks a rule is treated as a deliberate override.

## v5 — 2026-07-30

- Added optional behavior-level tagging (1 = below average, 2 = average,
  3 = above average) per student, with an editable legend (labels aren't
  hardcoded, so the tool doesn't impose its own value judgment on a kid).
- Untagged students default to "2," same optional/override pattern as
  gender tagging.
- Shuffle logic now automatically keeps "1"-tagged students apart (reusing
  the same per-view adjacency rules as custom "keep apart" constraints) and
  spreads "3"-tagged students so each table/row gets one.
- Behavior tags never render on the chart, on screen or in print —
  algorithm-only, since charts can end up posted, photographed, or seen by a
  substitute or parent.
- Same honest-limits behavior as custom rules: if the ratio of "1"s to
  tables makes full separation impossible, it does its best and says so in
  the warnings rather than failing silently.

## v4 — 2026-07-30 — merge into a single tool

- Merged the separate "Seating chart generator" and "Dot spot generator"
  into one app with a **Table pods / Rows / Dot spots** toggle, under the
  new name **Classroom Seating Planner**.
- Roster, gender tags, and custom rules became shared state across all
  three views — load a class once, switch freely between views.
- Save/load file updated to store all three layout configs plus which view
  was active.
- Follow-up fix (same version): switching tabs originally reshuffled a
  fresh random arrangement every time; changed so each view remembers its
  last arrangement and only reshuffles on an explicit "Shuffle again" or
  when the underlying roster actually changes (new load, clear, sample, or
  loading a saved class).

## v3 (seating chart) / v2 (dot spot generator) — 2026-07-28 → 2026-07-30

- Added "Save this class" / "Load saved class": exports roster, gender
  tags, custom rules, and layout to a small downloadable `.json` file, and
  re-imports it later — avoiding re-pasting everything each time.
- `localStorage` was considered and explicitly ruled out: it's tied to one
  device/browser, and Claude's artifact environment doesn't support it at
  all, so it would've silently failed when run as a published artifact.
  A real backend/database was also considered and ruled out for breaking
  the "no hosting expense" constraint.

## Dot spot generator (v1) — 2026-07-28

- New sibling tool for carpet-based seating: same roster paste, gender
  auto-guess, plain-English rules, sample button, and print/PDF flow as the
  original, applied to a customizable grid of dots (default 4×6, later
  changed to 5×6 before being reverted back to 4×6 in v7 of the merged tool).
- "Keep apart" rules check all 8 directions (including diagonals) on the
  grid, not just same-row, since that's more realistic for carpet seating.
- Each dot rendered as a slightly different shade of navy blue with a spot
  number, so a teacher can also just call out "go to spot 14."

## Seating chart generator v2 — 2026-07-28

- Not a feature change — a fresh regeneration of the same artifact under a
  new name, created to work around a persistent "already published/shared"
  error when trying to use Claude's Artifact publish feature. (That error
  was never fully resolved within the conversation; it's part of why this
  project later moved to a real static host instead of relying on Artifact
  publishing.)

## Seating chart generator (v1, unversioned) — 2026-07-28

Initial build. Established the core pattern the app still follows:

- Single self-contained `.html` file — no server, no account, no hosting
  cost — chosen explicitly over a hosted app or a "Claude skill" so
  non-Claude-using teachers could still use it.
- Layout setup (table/pod count and seats per table), roster paste (one
  name per line), plain-English custom rules (e.g. "keep Peter and Paul
  apart") with a "detected rules" preview step so a misparse doesn't
  silently fail.
- Manual M/F/skip gender tagging per student for the balance rule, later
  replaced in the same version by auto-guessing from a ~300-name list with
  one-click override.
- "Run a sample seating chart" button with fake data, for onboarding before
  pasting a real roster.
- Print/Save-as-PDF via the browser's native print dialog — no external
  dependencies.
- Visual identity: chalkboard-green header, warm index-card paper,
  red-pen/chalk-gold accents.
