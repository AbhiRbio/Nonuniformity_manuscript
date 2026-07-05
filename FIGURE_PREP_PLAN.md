# Figure Preparation Working Plan — Non-uniformity manuscript

**Target journal:** *Biophysical Journal* (BJ), a **Cell Press partner journal** (Biophysical Society / Elsevier).
**Consequence:** BJ's author page defers figure preparation to the **Cell Press figure guidelines**; the two pages together are the authority for everything below.

> **Verified 2026-07-05** against the live pages:
> - BJ information for authors — `https://www.cell.com/biophysj/authors`
> - Cell Press figure guidelines — `https://www.cell.com/information-for-authors/figure-guidelines`
>
> Where the two differ slightly (single-column and full widths), the safe target is the **smaller** of the two, noted inline. No values are unverified anymore.

---

## 1. The one rule everything hangs on

**Design every plot at its final printed size, at 100%, and never rescale a plot after export.**

The manuscript spec (Arial 6 pt, `labelpad=1.0`, `axes.linewidth=0.6`) is only meaningful at 1:1. Export at 6 pt and then shrink to 70% in Inkscape and the text becomes ~4.2 pt — below the 6 pt floor and inconsistent with the other panels. If a plot is the wrong size, change `figsize` in the notebook and re-export; do not scale it in Inkscape. Cell Press says the same in its own words: *use a vector program such as Inkscape to assemble figures and verify that at final print size each image is ≥ 300 ppi.* Sizing happens in matplotlib; Inkscape only assembles.

---

## 2. Verified specifications

### Widths
These bound the **whole figure**; panels are arranged inside them. BJ is a two-column journal, so research-article figures use the two-column set.

| Slot | Cell Press | BJ author page | Design target (safe for both) |
|---|---|---|---|
| 1 column | 8.5 cm (85 mm) | 3.25 in (82.55 mm) | **≤ 82.5 mm** |
| 1.5 column | 11.4 cm (114 mm) | — not listed | 114 mm |
| Full width | 17.4 cm (174 mm) | 6.75 in (171.45 mm) | **≤ 171 mm** |

### Everything else

| Parameter | Verified requirement |
|---|---|
| Height / overall size | Each figure must fit **one page**; recommended max box **6.5 × 8 in = 165 × 203 mm** to leave room for margins and the caption. |
| Font family | **Arial only**, fonts **embedded**. |
| Font size | **6–8 pt at final size.** 6 pt is the floor — compliant; use 7 pt where a panel has room. |
| Line weight / stroke | **0.5–1.5 pt** at final size. |
| Panel labels | **Capital letters** (A, B, C…). The figure is numbered as a whole (**Figure 1**, never 1A/1B). |
| Titles & legends | **Not in the image file** — placed at the end of the manuscript text. No parentheticals, citations, or footnotes in a figure title. |
| Scale bars | **Required on all microscopy images.** |
| Colour | Encode as **RGB**. Figures publish colour-online / B&W-print unless you pay for print colour. |
| Colour accessibility | **Red and green must not be used together.** |
| Resolution (at final size) | Colour/grayscale **≥ 300 dpi**; black-and-white bitmap **≥ 500 dpi**; line art **≥ 1000 dpi**. Verify every raster ≥ 300 ppi at final size. |
| Production formats | **TIFF or PDF preferred** (EPS for pure vector; JPG/CDX also accepted). One file per figure, **all panels in a single-page file**, named e.g. `Figure 1.pdf`, **≤ 20 MB**. |
| Layers | **Flatten to one layer** before saving the final production file. |
| Vertical space | **Limit vertical space between panels** to only what visual clarity needs. |
| Data display | For quantitation graphs, **plot individual data points** alongside mean ± error where practical (see §6 note — applies mainly to Figs 2–4, not the dense WD time-series). |
| Gray fills | Keep ≥ 20% different from other fills; no lighter than 10% or darker than 80%. |

---

## 3. Cross-submission stays cheap

BJ / Cell Press sit at the **tight end** of the field, so designing the composite to **≤ 171 mm full / ≤ 82.5 mm single** with **Arial 6–8 pt** and **0.5–1.5 pt** lines keeps you inside almost every other journal's limits — you'll just have small side margins at journals with wider columns. Because font size and line weight live in one central `rcParams` block and panel sizes live in `save_panel(...)` calls, changing journal is: edit those numbers → re-run the export cell → re-import. Nothing is redrawn.

| Journal | 1 column | Full width | Font floor |
|---|---|---|---|
| **Biophysical J. / Cell Press** (verified) | 82.5–85 mm | 171–174 mm | 6 pt (6–8 range) |
| PNAS | ~87 mm | ~178 mm | ~6–8 pt |
| JCB | ~85 mm | ~178 mm | ~6 pt |
| eLife | flexible | ~174 mm | ~8 pt |
| Nature | 89 mm | 183 mm | ~5 pt |

(Non-BJ rows remain approximate — confirm against each journal's page before switching.)

---

## 4. matplotlib → page bridge

`figsize` is in **inches**: `figsize = (width_mm / 25.4, height_mm / 25.4)`. Single column = `82.5/25.4 ≈ 3.25 in`; full width = `171/25.4 ≈ 6.73 in`.

The applied central style (now in the notebook) — all within the verified spec:

```python
mpl.rcParams.update({
    'font.family':'Arial', 'font.size':6, 'axes.labelsize':6,
    'axes.labelweight':'regular', 'axes.labelpad':1.0, 'axes.titlesize':7,
    'xtick.labelsize':6, 'ytick.labelsize':6, 'legend.fontsize':6,
    'axes.linewidth':0.6, 'xtick.major.width':0.6, 'ytick.major.width':0.6,
    'xtick.major.size':3, 'ytick.major.size':3,
    'axes.spines.top':False, 'axes.spines.right':False, 'axes.grid':False,
    'pdf.fonttype':42, 'svg.fonttype':'none',   # embedded / editable text
})
```

`save_panel(fig, name, subdir, w_mm, h_mm)` (in the paths cell) locks the physical size and writes SVG + PDF with **no** `bbox_inches='tight'`. Work from the SVG in Inkscape; the **final composite is exported as PDF** (SVG is not a Cell Press production format).

---

## 5. Inkscape workflow for painless rounds

1. **Re-export in place.** Fix each panel's outer canvas so every re-export is identical; revising a panel is "overwrite the file, re-import." Avoid `bbox_inches='tight'` (it trims to content and lets size drift); `save_panel` already omits it.
2. **Vector, text-as-text.** SVG for import (editable Arial via `svg.fonttype='none'`); flatten to paths only on a final copy. Cell Press explicitly endorses Inkscape for assembly.
3. **Never resize a plot inside Inkscape** — change `figsize` and re-export.
4. **Document at final size in mm.** Set the canvas to ≤ 171 mm wide; guides at column edges and row baselines; snap panels (Align & Distribute).
5. **Layer discipline while editing;** a "labels" layer for panel letters, scale bars, brackets. **Flatten to one layer for the final file only.**
6. **Panel letters (8 pt bold Arial) and shared annotations in Inkscape**, not matplotlib.
7. **Match hand-drawn elements to the spec:** 0.6 pt stroke = 0.21 mm; Arial 6–8 pt; Okabe-Ito palette (teal `#009E73`).
8. **Limit vertical space between panels**; resize the page to the drawing before exporting.
9. **Export the final figure as PDF** (fonts embedded), one file per figure, `Figure 1.pdf`, ≤ 20 MB. Verify at 100% that every raster reads ≥ 300 ppi.

---

## 6. Figure 1 — measured audit + required changes

### 6.1 What the current `Figure1.pdf` actually contains (measured)

| Property | Measured | Verdict vs verified spec |
|---|---|---|
| Page / canvas | A4, 210 × 297 mm | ✗ Not a figure size; ~81 mm blank below content. |
| Content bounding box | **197.6 × 196.9 mm** | ✗ Over full width (171 mm BJ / 174 mm CP) by ~15%. |
| Plot text (D, E) | 4.3–4.5 pt | ✗ Below the 6 pt floor. |
| Other text (time-stamps, "Non-uniform/Uniform", letters, B title) | 12.0 pt | ✗ Above the 6–8 pt range and inconsistent. |
| Panel letters B–E | 12.0 pt bold | ✗ Should be ~8 pt bold capitals. |
| Median line weight (E) | 2.0 pt | ✗ Over the 0.5–1.5 pt max. |
| Raster panels | 677 ppi (B), 580 ppi (C) | ✓ Well over 300 dpi. |
| Font family | Arial, embedded + subsetted | ✓ Compliant (Arial only). |

### 6.2 Root cause

The plots were exported at `figsize=(8, 4) = 203 × 102 mm` then **scaled down in Inkscape**, dragging 12 pt text to ~4.3 pt. The 12 pt annotations were placed independently and never scaled. One violation of the §1 rule produced both problems.

### 6.3 Fixed in the notebook (aesthetics only; analysis functions byte-identical)

`WD_quick`, `circle_WD`, `process_run_data`, and `median_and_iqr_errors` are **untouched** (verified byte-identical to the upload). Changes:

- **Central style:** `font.size` 12 → **6**; labels **bold → regular**; `labelpad` 5.0 → **1.0**; **added `axes.linewidth: 0.6`**; tick width 1 → **0.6**; tick length 6 → **3**; `titlesize` → 7. `pdf.fonttype=42` / `svg.fonttype='none'` retained.
- **Panel D (single-run trace):** `figsize` (8,4) → **(85, 50) mm**.
- **Panel E (across distributions — key panel):** `figsize` (8,4) → **(114, 64) mm**, deliberately larger than D.
- **Median line weight 2 → 1.5 pt** in the plotting helper, to meet the verified 0.5–1.5 pt rule (the one line touched in that helper; band edge left at 1 pt).
- **Added `save_panel(...)`**; commented `save_panel` calls replace the old `savefig` lines (no `bbox_inches='tight'`).

Re-running D and E now exports 6 pt / ≤1.5 pt panels at final size, ready for 1:1 placement.

*Note on the data-display recommendation:* Cell Press suggests plotting individual data points on quantitation graphs. For the WD-vs-time panels (median + IQR across many runs over 150 timepoints) individual traces would be unreadable, so the median+band is appropriate; apply the point-overlay recommendation to the summary/quantitation plots in Figs 2–4.

### 6.4 To do in Inkscape (the composite — the notebook can't do these)

1. **Rebuild on a ≤ 171 mm-wide canvas** and resize the document to the content (removes the A4 frame and the 81 mm blank; also satisfies "limit vertical space").
2. **Re-import D and E at their exported size and do not resize them** — this lifts axis text from 4.3 pt to 6 pt.
3. **Re-set the 12 pt elements:** image time-stamps and "Non-uniform/Uniform" to **6–7 pt**; **panel letters to 8 pt bold capitals**.
4. **Move the B title sentence into the figure legend** (in the manuscript text) — required: titles/legends must not be in the image file.
5. **Grow panel E** into the reclaimed space; keep D smaller. (E can go up to full width if placed on its own row.)
6. **Add scale bars to B and C** — required on microscopy images; bake `scale_bar` into the Cytosim `display=(...)` block, or draw a fixed-length bar + label on the labels layer.
7. **Recolour the filament ends** — **required**: red and green must not be used together, and capped = red / growing = green currently violates this. Use a post-hoc `coloring`/`color` change in `properties.cmo` (e.g. vermillion vs bluish-green from Okabe-Ito).
8. **Export the composite as PDF** (fonts embedded, flattened), named `Figure 1.pdf`, ≤ 20 MB; confirm every raster ≥ 300 ppi at final size.

### 6.5 Painless re-export loop

Uncomment the `save_panel(...)` lines → run the two panel cells → SVGs land in `…/figure1/`. In Inkscape, **File → Import** replaces each panel in place (same size every time; no `bbox_inches='tight'` to drift it). Panel letters, scale bars, and montage labels live on their own layer and survive a plot re-export. A revision round is: edit cell → re-run → re-import.

---

## 7. Pre-submission checklist

- [ ] Every panel exported at final physical size; nothing rescaled in Inkscape.
- [ ] Whole figure ≤ 171 mm wide (full) or ≤ 82.5 mm (single); fits one page with its caption.
- [ ] All text Arial, embedded, 6–8 pt at final size, consistent across panels.
- [ ] All lines/strokes within 0.5–1.5 pt at final size.
- [ ] Plots vector; every raster ≥ 300 ppi at final size (B&W ≥ 500; line art ≥ 1000).
- [ ] Colour is RGB; **no red+green together**; palette accessible (Okabe-Ito).
- [ ] Panel letters = capital letters, uniform (8 pt bold); figure numbered as a whole (Figure 1).
- [ ] Scale bars present on all microscopy panels and baked in.
- [ ] Titles/legends removed from the image and placed in the manuscript text.
- [ ] Final file = PDF or TIFF, fonts embedded, flattened, one file per figure named `Figure 1.pdf`, ≤ 20 MB.

---

## 8. If we switch journals later

1. Look up the new journal's single/full width, font floor, line-weight range, resolution, formats.
2. Edit `font.size` / `axes.linewidth` in the central `rcParams` block if their floors/ranges differ.
3. Update `w_mm` / `h_mm` in the `save_panel` calls.
4. Re-run the export cell; re-import the SVGs into the Inkscape master (they drop into place because the sizes are locked).
5. Re-run the checklist.

Because the design is final-size, vector, and centrally styled, a journal switch is minutes per figure, not a redraw.
