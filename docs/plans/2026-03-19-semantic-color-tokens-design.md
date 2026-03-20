# Semantic color tokens — design

**Status:** Adopted (spec). Code may still reference `GlyphColors` directly until a migration pass.

**Goal:** One vocabulary for *meaning* (surfaces, content, borders, accents, feedback) that matches how Glyph components already behave, with predictable naming patterns and a clear map to `GlyphColors` and theme APIs.

---

## Principles

1. **Spec before refactor** — Tokens are defined here first; `GlyphColorTokens` and widgets can adopt them incrementally.
2. **Patterned names** — Groups use consistent suffixes (`Container` for feedback pairs, `surface` + modifier for layers/states).
3. **Dart API style** — Documented canonical identifiers use **lowerCamelCase** (e.g. `borderStrong`, not `BorderStrong`).
4. **Single source for hex** — Values stay on `GlyphColors` until a deliberate move; semantic tokens *point to* those constants.
5. **Two reds** — Theme/destructive emphasis (`accentDanger` → `ColorScheme.error`) stays separate from semantic **critical** feedback (`statusDanger` / `statusDangerSurface`).

---

## Groups

| Group | Role |
|--------|------|
| **background** | Outermost app canvas behind chrome. |
| **surface** | In-app layers: default panels, subtle fills, disabled fills, optional nav/floating. |
| **content** | Text and icon foreground emphasis. |
| **border** | Dividers and control outlines. |
| **accent** | Brand / primary interactive color and related subtleties. |
| **feedback** | Semantic status: success, neutral, attention, critical — each as **foreground + container** where applicable. |

---

## Token catalog

### Background

| Token | `GlyphColors` | Notes |
|--------|----------------|--------|
| `background` | `bgCanvas` | Scaffold/shell canvas (`GlyphScaffoldStyle`, etc.). |

### Surface

| Token | `GlyphColors` | Notes |
|--------|----------------|--------|
| `surface` | `bgSurface` | Default card/panel/input face. |
| `surfaceSubtle` | `bgBody` | Page/scaffold fill, hover wash on stroke-style controls. |
| `surfaceSidebar` | `bgSidebar` | Sidebar chrome; also used as **selected** list wash (e.g. dropdown). |
| `surfaceFloating` | `bgSurface` | Same fill as `surface` today; “floating” is expressed with shadow/radius in components. |
| `surfaceDisabled` | `borderLight` | **Disabled fill** for filled/stroke buttons and similar — same swatch as light border today; not a separate neutral gray. If this feels misleading, alias mentally as `fillDisabled`. |
| `surfaceStrong` | *Unassigned* | No distinct token in the palette yet; reserve for a future “highest” surface step or deprecate if light theme never needs it. |

### Content

| Token | `GlyphColors` | Notes |
|--------|----------------|--------|
| `content` | `textPrimary` | Primary body and strong labels. |
| `contentSubtle` | `textSecondary` | Supporting text, nav default, table headers. |
| `contentDisabled` | `textTertiary` | Disabled, hints, separators, weak chrome. |
| `onAccentPrimary` | `accentSolidText` | Foreground on solid primary accent (badges, filled buttons, `onPrimary`). |

### Border

| Token | `GlyphColors` | Notes |
|--------|----------------|--------|
| `border` | `borderLight` | Hairlines, dividers, soft outlines. |
| `borderStrong` | `borderMedium` | Inputs, tables, pagination. |
| `borderDisabled` | `borderMedium` | Disabled control outline (matches current text field behavior). Same value as `borderStrong` in light theme; separate **role** for future themes. |
| `borderFocus` | `textPrimary` | Focus ring color used by `GlyphTextFieldStyle` / `InputDecorationTheme` today. |

### Accent

| Token | `GlyphColors` | Notes |
|--------|----------------|--------|
| `accentPrimary` | `accentSolid` | Primary solid; maps to `ColorScheme.primary`. |
| `accentPrimarySubtle` | `accentBlue` | Reserved for links, focus accents, selection — documented in palette, not yet wired through all components. |
| `accentPrimaryContainer` | `accentBlueSurface` | Soft wash paired with `accentPrimarySubtle`. |
| `accentDanger` | `accentDanger` | Destructive emphasis at theme level; maps to `ColorScheme.error`. |

### Feedback

Each semantic level uses **foreground + container** where the design uses a pair (badges, alerts).

| Token | `GlyphColors` | Notes |
|--------|----------------|--------|
| `feedbackSuccess` | `statusSuccess` | |
| `feedbackSuccessContainer` | `statusSuccessSurface` | |
| `feedbackAttention` | `statusWarning` | |
| `feedbackAttentionContainer` | `statusWarningSurface` | |
| `feedbackCritical` | `statusDanger` | Semantic error state (badges, etc.). |
| `feedbackCriticalContainer` | `statusDangerSurface` | |
| `feedbackNeutral` | `textSecondary` | Foreground for neutral badge. |
| `feedbackNeutralContainer` | `borderLight` | Background for neutral badge — **pairing**, not a unique third gray in the palette. |

---

## Theme alignment

`GlyphTheme.light()` already maps a subset to `ColorScheme`:

| `ColorScheme` field | Maps from |
|---------------------|-----------|
| `primary` | `accentPrimary` → `accentSolid` |
| `onPrimary` | `onAccentPrimary` |
| `surface` | `surface` |
| `onSurface` | `content` |
| `surfaceContainerLowest` | `surfaceSubtle` |
| `secondary` | `contentSubtle` |
| `onSecondary` | `onAccentPrimary` |
| `outlineVariant` | `border` |
| `outline` | `borderStrong` |
| `error` | `accentDanger` |
| `onError` | `onAccentPrimary` |

Everything else (sidebar, feedback pairs, `accentPrimarySubtle`, `borderFocus`, `surfaceDisabled`, `background`, etc.) belongs in **`GlyphColorTokens`** (or component style structs) when you expand the extension.

---

## Usage rules (for authors)

1. **Prefer theme** — Use `Theme.of(context).colorScheme` when the role matches the table above.
2. **Use `GlyphColorTokens`** — For tokens not on `ColorScheme`, once fields exist: `context.glyphColors`.
3. **Reserve `GlyphColors`** — For theme/token **definitions** and generated defaults, not scattered in new widget code.
4. **Filled button hover/pressed** — Today literal `Color(0xFF0D0D0D)` / `0xFF080808`; consider promoting to named tokens later (`accentPrimaryHover` / `accentPrimaryPressed`) without blocking this spec.

---

## Component alignment (summary)

- **Buttons / icon buttons / text fields / dropdown triggers** — Share the same stroke pattern: `surface` / `surfaceSubtle` / `border` / `borderStrong` / `content` / `contentDisabled`, plus `accentPrimary` / `onAccentPrimary` for filled variants.
- **Dropdown panel** — `surface`, `borderStrong`, `content`, `surfaceSidebar` (selected), `surfaceSubtle` (hover).
- **Badges** — `accentPrimary` + `onAccentPrimary`; feedback pairs; neutral uses `feedbackNeutral` + `feedbackNeutralContainer`.
- **Tables / pagination / app bar** — `surface`, `border`, `borderStrong`, `contentSubtle`.

---

## Changelog

| Date | Change |
|------|--------|
| 2026-03-19 | Initial design: user vocabulary + mappings + `feedbackCritical*` + `surfaceSidebar` + `borderFocus`. |
