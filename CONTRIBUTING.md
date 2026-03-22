# Contributing to Liquidity.ai

Welcome to the Liquidity.ai intern team. This guide covers everything you need to get started contributing.

## Prerequisites

- [Git](https://git-scm.com/download) installed
- [Node.js 18+](https://nodejs.org/) installed
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed (for PostgreSQL)
- A [GitHub](https://github.com/) account

## Setup (One Time)

### 1. Fork the Repository

Go to [github.com/Shellshock9001/LiquidityAI-FinTech](https://github.com/Shellshock9001/LiquidityAI-FinTech) and click the **Fork** button (top right). This creates YOUR copy of the repo.

### 2. Clone Your Fork

```bash
# Replace YOUR_GITHUB_USERNAME with your actual GitHub username
git clone https://github.com/YOUR_GITHUB_USERNAME/LiquidityAI-FinTech.git
cd LiquidityAI-FinTech
```

### 3. Add the Upstream Remote

```bash
git remote add upstream https://github.com/Shellshock9001/LiquidityAI-FinTech.git
```

This lets you pull the latest changes from the main repo.

### 4. Install Dependencies

```bash
npm install
```

### 5. Start the Dev Server

```bash
# Start PostgreSQL (if using Docker)
docker-compose up -d

# Start the backend
npm run server

# In a separate terminal, start the frontend
npm run dev
```

## Working on a Task

### 1. Sync with upstream first

```bash
git checkout dev
git pull upstream dev
```

### 2. Create a feature branch

```bash
# Use this naming convention: feat/task-{ID}-{short-description}
git checkout -b feat/task-1.1-entity-schema
```

### 3. Make your changes

Work on the files listed in your task's deliverables.

### 4. Commit often with descriptive messages

```bash
git add -A
git commit -m "feat: design FIRMS table with 20+ fields (Task 1.1)"
git commit -m "feat: add investor_categories and industry_verticals taxonomy tables"
git commit -m "feat: seed 50+ verified firms with source_links"
```

### 5. Push to YOUR fork

```bash
git push origin feat/task-1.1-entity-schema
```

### 6. Create a Pull Request

1. Go to YOUR fork on GitHub
2. Click **"Compare & pull request"**
3. Set base repository to `Shellshock9001/LiquidityAI-FinTech`, base branch to `dev`
4. Fill out the PR template (it auto-populates)
5. Submit the PR

### 7. Record in the Task Board

Paste your PR link in the task board as proof of work.

## Branch Strategy

```
main       ← production-ready (admin merges only)
  └── dev  ← integration branch (PRs target here)
       ├── feat/task-1.1-entity-schema
       ├── feat/task-2.1-file-upload
       └── feat/task-3.2-capital-browser
```

- **Never push directly to `main` or `dev`**
- Always create a feature branch from `dev`
- PRs go from your fork → `dev` on the main repo

## Commit Message Format

```
type: short description (Task X.Y)

# Types:
feat:     New feature or functionality
fix:      Bug fix
docs:     Documentation changes
style:    CSS/formatting changes (no logic change)
refactor: Code restructuring (no feature change)
test:     Adding or updating tests
chore:    Build, config, or tooling changes
```

## Code Style

- **Routes**: Follow patterns in `server/routes/userRoutes.js`
- **Auth**: Use `authenticate` middleware for protected routes
- **RBAC**: Use `requirePermission('permission.name')` for role checks
- **Audit**: Log all mutations with `db.js` → `queries.insertAudit`
- **Frontend API calls**: Follow patterns in `src/pages/SettingsPage.jsx`
- **Auth context**: Use `useAuth()` hook for auth state

## Design System

All UI components MUST use the existing design system in `src/index.css`:

| Element | CSS Class | Notes |
|---------|-----------|-------|
| Cards | `.card` | 10px radius, 18px padding |
| Primary buttons | `.btn .btn-primary` | Gold background |
| Ghost buttons | `.btn .btn-ghost` | Transparent |
| Data tables | `.data-table` | Monospace headers |
| Tags (gold) | `.tag .tag-amber` | Investor type badges |
| Tags (teal) | `.tag .tag-teal` | Industry badges |
| Tags (status) | `.tag .tag-green/.tag-red` | Status indicators |
| Stat values | `.stat-value` | Libre Baskerville, 28px |

**Colors**: Use CSS variables only — `var(--accent)`, `var(--teal)`, `var(--bg)`, etc.
**Fonts**: Syne (body), JetBrains Mono (labels), Libre Baskerville (headings)

## Source Policy

All data must come from authoritative sources:

| Allowed | Examples |
|---------|----------|
| Government/regulator | sec.gov, finra.org, nist.gov |
| Official vendor docs | expressjs.com, react.dev, postgresql.org |
| Standards bodies | OWASP, NIST, ISO |
| Official firm websites | blackstone.com, sequoiacap.com |

| NOT Allowed | Why |
|-------------|-----|
| Wikipedia | Anyone can edit, unverifiable |
| Reddit, StackOverflow | Anonymous, may be outdated |
| Medium, Dev.to | Unvetted blog posts |
| Investopedia | Third-party summary, not primary source |

## Getting Help

Use the **Liquidity.ai Assistant** in the task board (bottom-right chat button). It has full knowledge of every task, the codebase, and can search the web for official documentation.
