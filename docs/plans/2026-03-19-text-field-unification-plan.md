# Glyph Text Field Unification Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Replace multiple form text input components with a single `GlyphTextField` that supports only `medium` and `large` sizes and matches stroke-style visuals.

**Architecture:** Rename and evolve the existing input component into `GlyphTextField`, remove `GlyphSearchInput`, and migrate all exports/examples to the new API. Keep the implementation in one widget file with a local size enum and explicit size-to-metrics mapping.

**Tech Stack:** Flutter, Dart, Widgetbook, `glyph_ui` component library tokens (`GlyphColors`, `GlyphRadius`).

---

### Task 1: Replace the form text input component source

**Files:**
- Create: `glyph_ui/lib/src/components/form/glyph_text_field.dart`
- Delete: `glyph_ui/lib/src/components/form/glyph_input_field.dart`
- Delete: `glyph_ui/lib/src/components/form/glyph_search_input.dart`

**Step 1: Write the failing test (or compile-time expectation)**

Create/update form component usage in a local scratch snippet (or existing use-case) to reference:

```dart
GlyphTextField(
  label: 'Cardholder Name',
  placeholder: 'John Doe',
  size: GlyphTextFieldSize.medium,
)
```

Expected initial result: unresolved symbol errors until rename is complete.

**Step 2: Run analysis to verify it fails**

Run: `cd glyph_ui && dart analyze`
Expected: FAIL with unresolved `GlyphTextField` and/or stale references.

**Step 3: Write minimal implementation**

- Move logic from `GlyphInputField` into new `glyph_text_field.dart`.
- Rename widget/state classes to `GlyphTextField` / `_GlyphTextFieldState`.
- Add enum:

```dart
enum GlyphTextFieldSize { medium, large }
```

- Add `size` property (default `.medium`).
- Map size to dimensions with private getters:
  - medium: current compact height/padding
  - large: increased min-height and vertical padding

**Step 4: Run analysis to verify compile passes for this task**

Run: `cd glyph_ui && dart analyze lib/src/components/form`
Expected: PASS for renamed component file.

**Step 5: Commit**

```bash
git add glyph_ui/lib/src/components/form/glyph_text_field.dart glyph_ui/lib/src/components/form/glyph_input_field.dart glyph_ui/lib/src/components/form/glyph_search_input.dart
git commit -m "refactor(form): unify inputs into GlyphTextField"
```

---

### Task 2: Migrate public exports and references

**Files:**
- Modify: `glyph_ui/lib/glyph_ui.dart`
- Modify: `glyph_ui/example/lib/widgetbook/forms.dart`
- Modify: `glyph_ui/example/lib/main.dart`

**Step 1: Write failing expectation**

Identify old symbols that must no longer exist:
- `GlyphInputField`
- `GlyphSearchInput`

Expected final state: all replaced with `GlyphTextField`.

**Step 2: Run analysis/check to verify old references fail**

Run: `rg "GlyphInputField|GlyphSearchInput|glyph_search_input\\.dart|glyph_input_field\\.dart" glyph_ui`
Expected: old references still present before edits.

**Step 3: Write minimal implementation**

- In `glyph_ui.dart`:
  - replace `export 'src/components/form/glyph_input_field.dart';`
  - remove `export 'src/components/form/glyph_search_input.dart';`
  - add `export 'src/components/form/glyph_text_field.dart';`
- In widgetbook:
  - replace `GlyphInputField` use-cases with `GlyphTextField`
  - remove search-input use-case or convert it to `GlyphTextField` trailing/placeholder example
- In `example/main.dart`:
  - rename component labels from `GlyphInputField`/`GlyphSearchInput` to `GlyphTextField`

**Step 4: Run analysis to verify references are clean**

Run:
- `rg "GlyphInputField|GlyphSearchInput|glyph_search_input\\.dart|glyph_input_field\\.dart" glyph_ui`
- `cd glyph_ui && dart analyze`

Expected:
- No remaining old symbol references in source.
- Analyzer passes.

**Step 5: Commit**

```bash
git add glyph_ui/lib/glyph_ui.dart glyph_ui/example/lib/widgetbook/forms.dart glyph_ui/example/lib/main.dart
git commit -m "refactor(form): migrate exports and examples to GlyphTextField"
```

---

### Task 3: Apply stroke-like visual tuning and size verification

**Files:**
- Modify: `glyph_ui/lib/src/components/form/glyph_text_field.dart`
- Test manually in: `glyph_ui/example/lib/widgetbook/forms.dart`

**Step 1: Write visual verification checklist (failing if unmet)**

Checklist:
- Border default is `GlyphColors.borderMedium`
- Border focused is `GlyphColors.textPrimary`
- Radius equals stroke button radius (`8`)
- Supports `.medium` and `.large` only

**Step 2: Run widgetbook/app to verify current behavior**

Run: `cd glyph_ui/example && flutter run -d chrome` (or your default target)
Expected: inspect use-cases and note any mismatch.

**Step 3: Write minimal implementation**

Adjust container/text-field paddings and constraints to:
- preserve current medium density
- increase large touch target and padding

Keep one `TextField` in render tree and preserve optional trailing widget.

**Step 4: Re-run analysis and manual visual check**

Run:
- `cd glyph_ui && dart analyze`
- Re-open widgetbook and verify both sizes visually

Expected: analyzer clean, visual checklist satisfied.

**Step 5: Commit**

```bash
git add glyph_ui/lib/src/components/form/glyph_text_field.dart glyph_ui/example/lib/widgetbook/forms.dart
git commit -m "feat(form): add medium and large sizes to GlyphTextField"
```

---

### Task 4: Final validation

**Files:**
- N/A (verification only)

**Step 1: Run full project checks**

Run:
- `cd glyph_ui && dart format lib example/lib`
- `cd glyph_ui && dart analyze`

Expected: formatting applied and analyzer passes.

**Step 2: Run targeted grep assertions**

Run:
- `rg "GlyphInputField|GlyphSearchInput" glyph_ui`

Expected: no matches.

**Step 3: Optional smoke test**

Run widgetbook/example and verify:
- both sizes render
- focus border transitions correctly
- trailing icon still aligns in both sizes

**Step 4: Commit formatting-only diffs if any**

```bash
git add glyph_ui
git commit -m "chore(form): finalize text field unification cleanup"
```

