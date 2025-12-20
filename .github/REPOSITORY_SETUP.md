# Repository Setup Guide

## Setting Up Proper Git Flow

### 1. Change Default Branch to `develop`

**Why:** Contributors should fork and work from `develop`, not `main`. Main should only receive stable, tested code.

**Steps:**

1. Go to: https://github.com/ClaudiaRojasSoto/db_seeder
2. Click **Settings** (top menu)
3. In left sidebar, click **General** (should be selected by default)
4. Find section "Default branch"
5. Click the switch icon (↔️) next to "main"
6. Select `develop` from dropdown
7. Click **Update**
8. Confirm the change

**Result:** When people fork/clone your repo, they'll get `develop` by default.

### 2. Protect `main` Branch

**Purpose:** Prevent direct pushes to production branch.

**Steps:**

1. Go to: https://github.com/ClaudiaRojasSoto/db_seeder/settings/branches
2. Click **Add rule**
3. Branch name pattern: `main`
4. Enable:
   - ☑️ Require a pull request before merging
   - ☑️ Require approvals (set to 1)
   - ☑️ Dismiss stale pull request approvals when new commits are pushed
   - ☑️ Require status checks to pass before merging (if you set up CI)
   - ☑️ Require branches to be up to date before merging
   - ☑️ Require conversation resolution before merging
   - ☑️ Do not allow bypassing the above settings
   - ☑️ Restrict who can push to matching branches (optional - you only)
5. Click **Create**

### 3. Protect `develop` Branch (Optional but Recommended)

**Purpose:** Ensure quality even in development.

**Steps:**

1. Click **Add rule** again
2. Branch name pattern: `develop`
3. Enable:
   - ☑️ Require a pull request before merging
   - ☑️ Require status checks to pass before merging
   - ☑️ Do not allow bypassing the above settings
4. Click **Create**

## Workflow After Setup

### For External Contributors

```bash
# 1. Fork on GitHub (gets develop by default)

# 2. Clone their fork
git clone git@github.com:THEIR_USERNAME/db_seeder.git
cd db_seeder

# 3. Create feature branch (from develop)
git checkout -b feature/my-feature

# 4. Make changes, commit, push
git add .
git commit -m "Add: my awesome feature"
git push origin feature/my-feature

# 5. Create PR on GitHub
#    Base: develop (your repo)
#    Compare: feature/my-feature (their fork)
```

### For You (Maintainer)

**Regular development:**
```bash
# Always work from develop
git checkout develop
git pull origin develop

# Create feature branch
git checkout -b feature/new-feature

# Work, commit, push
git push origin feature/new-feature

# Create PR: feature/new-feature → develop
# Merge via GitHub after review
```

**Release to production:**
```bash
# When develop is stable and tested
git checkout main
git pull origin main
git merge develop
git push origin main

# Tag the release
git tag -a v0.2.0 -m "Release v0.2.0: description"
git push origin v0.2.0

# Build and publish gem
gem build db_seeder.gemspec
gem push db_seeder-0.2.0.gem

# Back to develop for continued work
git checkout develop
```

## Branch Strategy Overview

```
┌─────────────────────────────────────────┐
│  develop (default branch)               │
│  • All development happens here         │
│  • Feature branches merge here          │
│  • Tested before going to main          │
└─────────────────────────────────────────┘
              ↓
         [Pull Request]
         [Code Review]
         [Tests Pass]
              ↓
┌─────────────────────────────────────────┐
│  main (production branch)               │
│  • Only stable, tested code             │
│  • Tagged with version numbers          │
│  • Source for gem releases              │
└─────────────────────────────────────────┘
              ↓
         [Git Tag: v0.x.0]
              ↓
┌─────────────────────────────────────────┐
│  RubyGems.org                           │
│  • Public gem releases                  │
│  • gem install db_seeder                │
└─────────────────────────────────────────┘
```

## Checking Current Setup

```bash
# See all branches
git branch -a

# See which branch is default (check on GitHub or)
git remote show origin | grep "HEAD branch"

# See protection status
# Must check on GitHub: Settings → Branches
```

## Current Status

- ✅ `main` branch exists with stable v0.1.0
- ✅ `develop` branch exists and is up to date with main
- ⏳ Default branch: Need to change from `main` to `develop`
- ⏳ Branch protection: Need to set up for both branches

## After Setup is Complete

Update CONTRIBUTING.md to reflect that contributors should:
1. Fork the repo (gets `develop` automatically)
2. Create feature branches from `develop`
3. Submit PRs to `develop` (not `main`)

---

**Next Steps:**
1. Change default branch to `develop` on GitHub
2. Set up branch protection rules
3. You're ready for external contributions!

