# Typography tokens implementation plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Replace legacy typography members on `GlyphTextStyles` with the Title / Subtitle / Paragraph / Label scale **only** (no extra named tokens), update `buildTextTheme()`, and migrate every in-repo usage under `glyph_ui/` and `glyph_ui/example/`.

**Architecture:** Single source file `glyph_typography.dart` holds all `const TextStyle` tokens. Semantic duplicates (`subtitleSmall` ≡ `labelMedium`, etc.) are `static const` aliases. `glyph_theme.dart` and component metrics/widgets swap old identifiers for new ones. No deprecated shims (big-bang).

**Tech stack:** Flutter (FVM), package `glyph_ui`, example app.

**Design reference:** [2026-03-19-typography-tokens-design.md](./2026-03-19-typography-tokens-design.md)

---

### Task 1: Rewrite `glyph_typography.dart`

**Files:**
- Modify: `glyph_ui/lib/src/tokens/glyph_typography.dart`

**Steps:**

1. Remove legacy styles (`h1`, `h2`, `h3`, `body`, `small`, `meta`, `metaItem`, `price`, `navLogo`, `buttonPrimary`, `badge`, `summaryTotal`).
2. Add all tokens from the design doc in order: define **`labelMedium` before** `subtitleSmall` so you can write `static const TextStyle subtitleSmall = labelMedium;` and `subtitleSmallStrong = labelMediumStrong;`.
3. Do **not** add component-specific tokens; map widgets to the scale (use `copyWith(color: …)` only where needed).
4. Reimplement `buildTextTheme()` using the mapping table in the design doc.
5. Update the top-level library doc comment.

**Verify:** `cd glyph_ui && fvm dart analyze lib/src/tokens/glyph_typography.dart` — no issues.

**Commit:** `git add glyph_ui/lib/src/tokens/glyph_typography.dart && git commit -m "feat(tokens): replace GlyphTextStyles with new typography scale"`

---

### Task 2: Theme and global styles

**Files:**
- Modify: `glyph_ui/lib/src/theme/glyph_theme.dart`

**Steps:**

1. Filled button `textStyle`: `labelMediumStrong.copyWith(color: GlyphColors.accentSolidText)` (non-const `WidgetStatePropertyAll` if needed).
2. `AppBarTheme.titleTextStyle`: `titleXsmall`.

**Verify:** `fvm dart analyze lib/src/theme/glyph_theme.dart`

**Commit:** `git add glyph_ui/lib/src/theme/glyph_theme.dart && git commit -m "fix(theme): use new typography tokens for button and app bar"`

---

### Task 3: App bar

**Files:**
- Modify: `glyph_ui/lib/src/components/app_bar/glyph_app_bar_metrics.dart`

**Steps:**

1. `titleTextStyle: GlyphTextStyles.h2` → `GlyphTextStyles.titleXsmall` (20px page title per design cheat sheet).

**Verify:** analyze file.

**Commit:** `git commit -am "fix(app_bar): use titleXsmall for app bar title metrics"`

---

### Task 4: Sidebar

**Files:**
- Modify: `glyph_ui/lib/src/components/sidebar/glyph_sidebar.dart`
- Modify: `glyph_ui/lib/src/components/sidebar/glyph_sidebar_metrics.dart`
- Modify: `glyph_ui/lib/src/components/sidebar/glyph_sidebar_style.dart`

**Steps:**

1. Brand text → `titleXsmall` in `glyph_sidebar.dart`.
2. `GlyphTextStyles.small` → `labelSmallStrong` for nav item base (was 13px w500; new equivalent 14 w500).
3. `GlyphTextStyles.meta` → `labelXsmall` for group title base in `glyph_sidebar_style.dart`.

**Verify:** analyze touched files.

**Commit:** `git add glyph_ui/lib/src/components/sidebar/ && git commit -m "fix(sidebar): migrate typography tokens"`

---

### Task 5: Buttons

**Files:**
- Modify: `glyph_ui/lib/src/components/button/glyph_button_metrics.dart`

**Steps:**

1. Replace `GlyphTextStyles.small` with `labelSmallStrong` (default strong label at 14).
2. For the variant that used `copyWith(height: 1.4)`, either keep `labelSmallStrong.copyWith(height: 1.4)` or drop if 1.3 from token is acceptable—prefer **minimal `copyWith`** only if widget layout still breaks.

**Verify:** analyze.

**Commit:** `git commit -am "fix(button): migrate label styles to new scale"`

---

### Task 6: Breadcrumbs

**Files:**
- Modify: `glyph_ui/lib/src/components/breadcrumbs/glyph_breadcrumbs_metrics.dart`

**Steps:**

1. `segmentTextStyle: GlyphTextStyles.small` → `labelSmallStrong`.

**Commit:** `git commit -am "fix(breadcrumbs): use labelSmallStrong"`

---

### Task 7: Dropdown

**Files:**
- Modify: `glyph_ui/lib/src/components/dropdown/glyph_dropdown_metrics.dart`
- Modify: `glyph_ui/lib/src/components/dropdown/glyph_dropdown.dart`

**Steps:**

1. Metrics: `small` → `labelSmallStrong`; `metaItem` → `labelSmallStrong` (same 14 w500) or `paragraphSmallStrong` if trigger should read as body—**use `labelSmallStrong`** for trigger label; keep semantics aligned with old metaItem.
2. Dart: `meta` → `labelXsmall`; `small` → `labelSmallStrong`.

**Commit:** `git commit -am "fix(dropdown): migrate typography tokens"`

---

### Task 8: Pagination

**Files:**
- Modify: `glyph_ui/lib/src/components/pagination/glyph_pagination_metrics.dart`

**Steps:**

1. `meta` → `labelXsmall` for summary and page labels (adjust `copyWith` if needed).

**Commit:** `git commit -am "fix(pagination): use labelXsmall"`

---

### Task 9: Data table

**Files:**
- Modify: `glyph_ui/lib/src/components/table/glyph_data_table_metrics.dart`

**Steps:**

1. Header/meta styles: `meta` → `labelXsmall`; `metaItem` → `labelSmallStrong`.

**Commit:** `git commit -am "fix(table): migrate header typography"`

---

### Task 10: Badge

**Files:**
- Modify: `glyph_ui/lib/src/components/badge/glyph_badge.dart`

**Steps:**

1. Badge label → `label2XsmallStrong` (or another label token from the scale).

**Commit:** `git commit -am "fix(badge): use label scale for badge text"`

---

### Task 11: Example widgetbook

**Files:**
- Modify: `glyph_ui/example/lib/widgetbook/cards.dart`

**Steps:**

1. `h2` → `titleXsmall` (with existing `copyWith(color: …)` if still needed).
2. `body` → `paragraphMedium`.

**Commit:** `git commit -am "chore(example): update cards widgetbook typography"`

---

### Task 12: Package-wide verification

**Steps:**

1. `cd glyph_ui && fvm flutter analyze`
2. `cd glyph_ui/example && fvm flutter analyze`

**Expected:** No errors; infos/warnings only if pre-existing.

**Commit:** (only if fixes needed) small follow-up commit.

---

### Task 13: Design + plan docs

**Files:**
- Already added: `docs/plans/2026-03-19-typography-tokens-design.md`
- This file: `docs/plans/2026-03-19-typography-tokens-implementation-plan.md`

**Steps:**

1. `git add docs/plans/2026-03-19-typography-tokens-design.md docs/plans/2026-03-19-typography-tokens-implementation-plan.md`
2. `git commit -m "docs: typography tokens design and implementation plan"`

---

## Execution choice (after plan is saved)

**1. Subagent-driven (this session)** — fresh subagent per task, review between tasks.

**2. Parallel session** — new session with executing-plans, batch with checkpoints.

Which approach do you want?
