# Semantic Color Naming — Design Spec

**Date:** 2025-03-18  
**Status:** Approved (design)  
**Scope:** Glyph UI design system — structure and naming of semantic colors for multiple product teams / external consumers.

---

## 1. Goals

- **Consistent structure:** Every semantic meaning has a main (foreground/fill) and, where needed, a surface (background tint) token.
- **Clear for consumers:** Multiple teams can discover and use tokens without overloading "accent" or "bg".
- **Role + variant:** Names follow a small taxonomy (Feedback, Interactive, Surfaces) with documented roles; token names stay short (meaning + Surface).

---

## 2. Role taxonomy

Semantic colors are grouped into three roles. Roles are for **documentation and mental model**; token names do not require a role prefix.

| Role | Purpose | Meanings |
|------|---------|----------|
| **Feedback** | Outcome or state of a process (success, warning, error, neutral/inactive) | success, warning, error, neutral |
| **Interactive / brand** | Primary actions, selection, focus, destructive actions | primary, primarySolid, danger |
| **Surfaces** | Page and container backgrounds (hierarchy only) | bgCanvas, bgSurface, bgSidebar, bgBody |

**Rules:**

- **Feedback** and **Interactive** tokens each have a **main** color (text/icon/fill) and a **Surface** variant (light background for badges, chips, highlights). Pattern: `{meaning}` and `{meaning}Surface`.
- **Surfaces** keep existing names: `bgCanvas`, `bgSurface`, `bgSidebar`, `bgBody`. The "meaning + Surface" pattern applies only to Feedback and Interactive.
- **Text/border** tokens are unchanged: `textPrimary`, `textSecondary`, `textTertiary`, `borderLight`, `borderMedium`.

---

## 3. Token list and naming

### 3.1 Feedback

| Token | Surface token | Use |
|-------|----------------|-----|
| success | successSurface | Live, Paid, positive outcome |
| warning | warningSurface | Pending, needs attention |
| error | errorSurface | Validation, failure feedback |
| neutral | neutralSurface | Sold out, Refunded, inactive |

### 3.2 Interactive / brand

| Token | Surface token | Use |
|-------|----------------|-----|
| primary | primarySurface | Focus, selection, links (accent blue) |
| primarySolid | onPrimary | Primary CTA button (black fill, white text) |
| danger | dangerSurface | Destructive actions (e.g. Delete) |

**Note:** `error` = feedback (e.g. "Payment failed"). `danger` = interactive (e.g. "Delete" button). Same hue allowed; two names keep usage clear.

### 3.3 Surfaces

| Token | Use |
|-------|-----|
| bgCanvas | Page background |
| bgSurface | Card/panel |
| bgSidebar | Side nav background |
| bgBody | Content area default |

### 3.4 Text and border (unchanged)

- textPrimary, textSecondary, textTertiary  
- borderLight, borderMedium  

---

## 4. Current → new name mapping

| Current (GlyphColors) | New name | Role |
|------------------------|----------|------|
| accentBlue | primary | Interactive |
| accentBlueSurface | primarySurface | Interactive |
| accentSolid | primarySolid | Interactive |
| accentSolidText | onPrimary | Interactive |
| accentDanger | danger | Interactive |
| (add) | dangerSurface | Interactive |
| statusSuccess | success | Feedback |
| statusSuccessSurface | successSurface | Feedback |
| statusWarning | warning | Feedback |
| statusWarningSurface | warningSurface | Feedback |
| (add) | error, errorSurface | Feedback |
| (add) | neutral, neutralSurface | Feedback |
| bgCanvas … bgBody | no change | Surfaces |

---

## 5. Implementation

### 5.1 GlyphColors

- Add new tokens: `error`, `errorSurface`, `neutral`, `neutralSurface`, `dangerSurface`, plus canonical names `primary`, `primarySurface`, `primarySolid`, `onPrimary`, `success`, `successSurface`, `warning`, `warningSurface`, `danger`.
- Keep existing names as **deprecated aliases** pointing to the same `Color` const so existing code keeps compiling (e.g. `@Deprecated('Use success') static const Color statusSuccess = success;`).

### 5.2 GlyphColorTokens (ThemeExtension)

- Extend to expose the full semantic set so widgets use `context.glyphColors.success`, `context.glyphColors.primary`, etc.
- Wire new tokens in `GlyphColorTokens.light()` and in `copyWith` / `lerp`.

### 5.3 Migration (phased)

1. **Phase 1:** Add new tokens and deprecated aliases in `glyph_colors.dart`; no breaking changes.
2. **Phase 2:** Add new names to `GlyphColorTokens` and theme; update theme and new code to use them.
3. **Phase 3:** Migrate existing components from old names to new; remove deprecations when no internal usages remain.

---

## 6. Out of scope

- Tag/categorical colors (e.g. ticket types) — structure applies if added later with the same meaning + Surface pattern.
- Renaming surface tokens from `bg*` to `canvas`/`surface`/etc. — kept as `bg*` to avoid churn unless decided otherwise later.
