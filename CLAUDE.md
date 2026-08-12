# CLAUDE.md

Claude-Code-specific working notes for this repo. For full project context
(origin story, requirements, design decisions, prior hosting/monetization
research), see [README.md](./README.md). For version history, see
[CHANGELOG.md](./CHANGELOG.md).

## Working conventions

- `index.html` is v7 — the first version tracked in this repo. v1–v6 exist
  only in the original build conversation
  (https://claude.ai/share/e07f3d1c-d049-4721-bd77-f0e8cb3a81d4), not as
  files here.
- This app has no `fetch()` calls, so it also works fine opened directly
  via `file://` — `./start.sh` is a convenience for parity with other
  projects, not a requirement (unlike health-dashboard).
- The app is fully self-contained by design: no backend, no `localStorage`,
  nothing uploaded or stored. Persistence is a download/upload class
  `.json` file. Preserve this property unless a deliberate decision is made
  to add a backend — see README's monetization section before doing that.
- Deployed via GitHub Pages: https://candeezymac.github.io/classroom-seating-planner/
  (repo made public to enable free Pages — no accounts/backend/data in the
  app, so this is low-risk). Deploys automatically from `main` on push, no
  build step. Next real step per the plan is a deliberate decision on
  accounts/monetization — see README's monetization section.
