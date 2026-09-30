# Apps Script fallback deployment

**Live URL:** https://script.google.com/macros/s/AKfycbzDBsqkD6TE-xSuvOsfwY_qHdxvs6m2FQcJE-SrHaehrvIrEgqGUMfzxKXAaVODY5Mf/exec
(Apps Script project name: "Classroom-seating-chart-google", deployed
2026-09-30. Deployed under Matt's own Google account — "Execute as: Me",
"Who has access: Anyone.")

This folder is **not** the primary deployment — GitHub Pages
(https://candeezymac.github.io/classroom-seating-planner/) is. This exists
only as a fallback for school networks that block `*.github.io` in their
content filter (a common, well-known issue with K-12 filters like Securly,
GoGuardian, or Lightspeed).

Hosting it as a Google Apps Script web app instead serves it from
`script.google.com`, a domain Google Workspace for Education networks
essentially always allow, since Classroom/Docs/Slides depend on it too.

## What's here

- **`Code.gs`** — the entire server-side code. Just one function
  (`doGet`) that serves `index.html` as a web page.
- **`index.html`** — an exact copy of the root `index.html`. Apps Script
  can't read files from this git repo directly, so this copy has to be
  pasted into the Apps Script project by hand (see the setup walkthrough
  Matt has from Claude Code). It is **not** auto-synced.

## Keeping it in sync

Whenever the root `index.html` changes, re-copy it here and re-paste it
into the Apps Script editor's `index.html` file, then create a new
deployment version (Deploy → Manage deployments → Edit → New version).
Since this is a low-traffic fallback, that's a manual, occasional step —
not worth automating unless it turns out people rely on this link a lot.
