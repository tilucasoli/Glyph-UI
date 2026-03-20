# Semantic color tokens — design

**Status:** Adopted (spec). Code may still reference `GlyphColors` directly until a migration pass.

**Goal:** One vocabulary for *meaning* (background, surfaces, content, borders, accents, feedback) with predictable naming patterns and a clear map to `GlyphColors`.

---

## Principles

1. **Spec before refactor** — Tokens are defined here first; `GlyphColorTokens` and widgets can adopt them incrementally.
2. **Patterned names** — Groups use consistent suffixes (`Container` for feedback pairs, `surface` + modifier for layers/states).
3. **Dart API style** — Documented canonical identifiers use **lowerCamelCase** (e.g. `borderStrong`, not `BorderStrong`).
4. **Single source for hex** — Values stay on `GlyphColors` until a deliberate move; semantic tokens *point to* those constants.
5. **No tokens beyond this doc** — The catalog below is the complete set; anything else stays on `GlyphColors` until you explicitly extend the vocabulary.

---

## Groups

| Group | Role |
|--------|------|
| **background** | Outermost app canvas behind chrome. |
| **surface** | In-app layers: default, subtle, strong, floating, disabled. |
| **content** | Text and icon foreground emphasis. |
| **border** | Dividers and control outlines. |
| **accent** | Primary accent and related subtleties. |
| **feedback** | Success, neutral, and attention — each as **foreground + container** where applicable. |

---

## Token catalog

### Background

| Token | `GlyphColors` | Notes |
|--------|----------------|--------|
| `background` | `bgCanvas` | Scaffold/shell canvas. |

### Surface

| Token | `GlyphColors` | Notes |
|--------|----------------|--------|
| `surface` | `bgSurface` | Default card/panel/input face. |
| `surfaceSubtle` | `bgBody` | Page/scaffold fill, hover wash on stroke-style controls. |
| `surfaceStrong` | *Unassigned* | No distinct value in the palette yet. |
| `surfaceFloating` | `bgSurface` | Same fill as `surface` today; elevation is shape/shadow, not a separate swatch. |
| `surfaceDisabled` | `borderLight` | Disabled fill for filled/stroke controls (same swatch as `border` today). |

### Content

| Token | `GlyphColors` | Notes |
|--------|----------------|--------|
| `content` | `textPrimary` | Primary body and strong labels. |
| `contentSubtle` | `textSecondary` | Supporting text, nav default, table headers. |
| `contentDisabled` | `textTertiary` | Disabled, hints, separators, weak chrome. |

### Border

| Token | `GlyphColors` | Notes |
|--------|----------------|--------|
| `border` | `borderLight` | Hairlines, dividers, soft outlines. |
| `borderStrong` | `borderMedium` | Inputs, tables, pagination. |
| `borderDisabled` | `borderMedium` | Disabled control outline. Same value as `borderStrong` in the light palette; separate **role** for theme overrides. |

### Accent

| Token | `GlyphColors` | Notes |
|--------|----------------|--------|
| `accentPrimary` | `accentSolid` | Primary solid fill. |
| `accentPrimarySubtle` | `accentBlue` | Interactive / link / focus accent. |
| `accentPrimaryContainer` | `accentBlueSurface` | Soft wash paired with `accentPrimarySubtle`. |

### Feedback

| Token | `GlyphColors` | Notes |
|--------|----------------|--------|
| `feedbackSuccess` | `statusSuccess` | |
| `feedbackSuccessContainer` | `statusSuccessSurface` | |
| `feedbackNeutral` | `textSecondary` | Neutral foreground. |
| `feedbackNeutralContainer` | `borderLight` | Neutral background — pairs with `feedbackNeutral`. |
| `feedbackAttention` | `statusWarning` | |
| `feedbackAttentionContainer` | `statusWarningSurface` | |

---

## Theme alignment

Where `GlyphTheme.light()` maps to `ColorScheme`, the **primitive** sources are:

| `ColorScheme` field | `GlyphColors` |
|---------------------|----------------|
| `primary` | `accentSolid` |
| `onPrimary` | `accentSolidText` |
| `surface` | `bgSurface` |
| `onSurface` | `textPrimary` |
| `surfaceContainerLowest` | `bgBody` |
| `secondary` | `textSecondary` |
| `onSecondary` | `accentSolidText` |
| `outlineVariant` | `borderLight` |
| `outline` | `borderMedium` |
| `error` | `accentDanger` |
| `onError` | `accentSolidText` |

---

## Usage rules (for authors)

1. **Prefer theme** — Use `Theme.of(context).colorScheme` when the Material role matches the mapping above.
2. **Use `GlyphColorTokens`** — For semantic fields once they exist on the extension: `context.glyphColors`.
3. **Reserve `GlyphColors`** — For theme/token **definitions** and for palette entries **not** listed in the catalog.

---

## Changelog

| Date | Change |
|------|--------|
| 2026-03-19 | Adopted vocabulary: background, surface\*, content\*, border\*, accentPrimary\*, feedback\* only. |
