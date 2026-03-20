# Typography tokens redesign

**Decision:** Big-bang migration (option 1). Replace the legacy `GlyphTextStyles` vocabulary with the new Title / Subtitle / Paragraph / Label scale in a single change set, updating all in-package call sites. No deprecated aliases.

**Spec fix:** The second “paragraph.medium” block (14px, letter spacing -0.1px) is named **`paragraphSmall` / `paragraphSmallStrong`** in code.

---

## Flutter mapping rules

- **`fontSize`:** px values from the spec as `double` literals (e.g. `44`, `18`).
- **`fontWeight`:** `FontWeight.w400` / `w500` per spec.
- **`height`:** line height as a multiplier of `fontSize` (Flutter `TextStyle.height`):
  - 110% → `1.1`
  - 120% → `1.2`
  - 130% → `1.3`
  - 150% → `1.5`
- **`letterSpacing`:** logical pixels, as given (e.g. `-1.3`, `0`).
- **`fontFamily`:** `Inter` (unchanged).
- **`leadingDistribution`:** omit unless a specific style needs it (legacy `small` used `proportional`; only reapply where a component still looks wrong after QA).

---

## Default colors (role-based)

| Role | Default `color` |
|------|-----------------|
| Title.* | `GlyphColors.textPrimary` |
| Subtitle.* | `GlyphColors.textPrimary` |
| Paragraph.* | `GlyphColors.textSecondary` |
| Label.* | `GlyphColors.textSecondary` |

Call sites override with `copyWith` when context requires (e.g. on-accent, errors).

---

## Token table (Dart identifiers)

All tokens live on **`GlyphTextStyles`** (keep the class name so the public type stays stable; only **members** change).

### Title

| Identifier | Size | Weight | Line height | Letter spacing |
|------------|------|--------|-------------|----------------|
| `titleXlarge` | 44 | 500 | 1.1 | -1.3 |
| `titleLarge` | 36 | 500 | 1.1 | -1.1 |
| `titleMedium` | 28 | 500 | 1.2 | -0.8 |
| `titleSmall` | 24 | 500 | 1.2 | -0.5 |
| `titleXsmall` | 20 | 500 | 1.2 | -0.5 |

### Subtitle

| Identifier | Size | Weight | Line height | Letter spacing |
|------------|------|--------|-------------|----------------|
| `subtitleMedium` | 18 | 400 | 1.3 | -0.2 |
| `subtitleMediumStrong` | 18 | 500 | 1.3 | -0.2 |
| `subtitleSmall` | 16 | 400 | 1.3 | -0.2 |
| `subtitleSmallStrong` | 16 | 500 | 1.3 | -0.2 |

### Paragraph

| Identifier | Size | Weight | Line height | Letter spacing |
|------------|------|--------|-------------|----------------|
| `paragraphMedium` | 16 | 400 | 1.5 | -0.2 |
| `paragraphMediumStrong` | 16 | 500 | 1.5 | -0.2 |
| `paragraphSmall` | 14 | 400 | 1.5 | -0.1 |
| `paragraphSmallStrong` | 14 | 500 | 1.5 | -0.1 |

### Label

| Identifier | Size | Weight | Line height | Letter spacing |
|------------|------|--------|-------------|----------------|
| `labelMedium` | 16 | 400 | 1.3 | -0.2 |
| `labelMediumStrong` | 16 | 500 | 1.3 | -0.2 |
| `labelSmall` | 14 | 400 | 1.3 | -0.1 |
| `labelSmallStrong` | 14 | 500 | 1.3 | -0.1 |
| `labelXsmall` | 12 | 400 | 1.3 | 0 |
| `labelXsmallStrong` | 12 | 500 | 1.3 | 0 |
| `label2Xsmall` | 10 | 400 | 1.3 | 0 |
| `label2XsmallStrong` | 10 | 500 | 1.3 | 0 |

### Duplicate metrics (semantic aliases)

`subtitleSmall` / `subtitleSmallStrong` match `labelMedium` / `labelMediumStrong` exactly. Implement as **alias references** (second name points to the same `const TextStyle` or `static const` forwarding) so the public API matches Figma semantics without drift.

---

## Tokens not in Figma (parity with current UI)

Legacy styles that have no exact match get **dedicated `const TextStyle`s** on the same class, documented as “composed from design intent,” so `ThemeData` and widgets stay const-friendly:

| Legacy | Proposed token | Rationale |
|--------|----------------|-----------|
| `buttonPrimary` (16 / w600 / accent text) | `filledButtonLabel` | Same size as label medium strong; weight **600** per current filled button; color `GlyphColors.accentSolidText`. |
| `navLogo` (20 / w700 / primary) | `sidebarBrand` | Based on `titleXsmall` size/spacing/height but **w700** and primary color. |
| `badge` (11 / w600 / secondary) | `badgeLabel` | Between `labelXsmall` and `label2Xsmall`; keep **11 / w600** until badge spec moves into the scale. |

---

## `buildTextTheme()` (Material 3)

Map `TextTheme` slots to the **closest** new tokens so `Theme.of(context).textTheme` remains usable. Suggested mapping:

| Slot | Token |
|------|-------|
| `displayLarge` | `titleXlarge` |
| `displayMedium` | `titleLarge` |
| `displaySmall` | `titleMedium` |
| `headlineLarge` | `titleSmall` |
| `headlineMedium` | `titleXsmall` |
| `headlineSmall` | `subtitleMediumStrong` |
| `titleLarge` | `subtitleSmallStrong` |
| `titleMedium` | `paragraphSmallStrong` |
| `titleSmall` | `labelXsmallStrong` |
| `bodyLarge` | `paragraphMedium` |
| `bodyMedium` | `paragraphSmall` |
| `bodySmall` | `labelXsmall` |
| `labelLarge` | `labelMediumStrong` |
| `labelMedium` | `labelSmallStrong` |
| `labelSmall` | `label2XsmallStrong` |

Adjust if visual QA shows better fits; document changes in the implementation PR.

---

## In-repo migration cheat sheet (legacy → new)

| Old | New (default) |
|-----|----------------|
| `h1` | `titleMedium` (28) — was 32px; new system is source of truth |
| `h2` | `titleXsmall` (app bar / page titles) |
| `h3` | `subtitleSmallStrong` or `paragraphMediumStrong` by context |
| `body` | `paragraphMedium` |
| `small` | `labelSmall` (14 / w500 strong variant: `labelSmallStrong`) |
| `meta` | `labelXsmall` |
| `metaItem` | `labelSmallStrong` |
| `price` | `subtitleMediumStrong` + `copyWith` if w600 needed |
| `navLogo` | `sidebarBrand` |
| `buttonPrimary` | `filledButtonLabel` |
| `badge` | `badgeLabel` |
| `summaryTotal` | `titleXsmall` or `subtitleMediumStrong` + weight/color per design |

Exact per-file choices are listed in the implementation plan.

---

## Verification

- `fvm flutter analyze` (package + example)
- Spot-check widgetbook / example screens for regressions (titles, buttons, sidebar, table headers, badges)

---

## Out of scope

- Token browser / Storybook reorganization beyond fixing broken references
- Changing non-`glyph_ui` worktrees under `.worktrees/`
