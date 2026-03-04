# Whitepaper Memory

## Completed Whitepapers
| Slug | Stage | Strapi ID | Last Updated |
|------|-------|-----------|--------------|
| flextail-whitepaper | Fact-checked + PDF recompiled | N/A | 2026-02-23 |

## Papers Already Read
| ArXiv ID / DOI | Title | Saved To | Notes |
|----------------|-------|----------|-------|
| 10.3390/s25123806 | Walkling et al. (2025) - HAR comparison FlexTail vs video | src/refs.bib (walkling2025) | FULL PAPER READ (PMC12196833). 10 participants, indoor only, 11 activities. Camera = OpenPose 1.7.0 (25 keypoints). Both FlexTail RDST and camera QUANT achieved F1=0.90 at 1s window. Standing-up: FlexTail 95% vs OpenPose 76% (confusion matrix accuracy). Dataset explicitly flagged as small by authors. NO 97% at 10s window (that figure is from Haghi 2023 previous paper). |
| 10.1007/s41693-025-00173-x | Sawicki/Düking et al. (2026) - SC3DP ergonomics | src/refs.bib (sawicki2026) | 60% reduction flexed posture, 63% exertion reduction |
| 10.3390/s23042066 | Haghi et al. (2023) - CNN+LSTM 97% accuracy | src/refs.bib (haghi2023) | Not cited in final whitepaper |
| 10.1055/s-0043-1761303 | Marx et al. (2023) - ROM pre/post spinal surgery | src/refs.bib (marx2023) | Clinical pilot, dorsale Korrekturspondylodese |
| Eur Spine J (van der Veen 2019) | SpinalMouse precision 1-2 degrees | src/refs.bib (spinalMouse) | Clinical surface measurement device |
| Gait & Posture (Ehara 1995) | Vicon RMSE 0.154mm | src/refs.bib (vicon_rmse) | Optical MoCap reference standard |
| Madgwick et al. (2011) | IMU/MARG gradient descent algorithm | src/refs.bib (madgwick2011) | Yaw drift in ferromagnetic environments |
| Burdorf & Sorock (1997) | Back disorder risk factors | src/refs.bib (ljungberg2004) | Stored under ljungberg2004 key |
| Daneshmandi et al. (2017) | Prolonged sitting effects | src/refs.bib (hawkins2007) | Stored under hawkins2007 key |
| 10.1016/j.jbiomech.2019.08.006 | Swain et al. (2020) - No consensus on causality of spine postures and LBP | src/refs.bib (swain2020) | Umbrella review of 41 systematic reviews; PMID 31451200. Used in clinical blindspot argument (background.tex). Key finding: association documented but causal inference blocked by absence of continuous real-world kinematic data. |

## Key Decisions
- [2026-02-23] [flextail-whitepaper] Use palatino + T1 fontenc instead of fontspec/TeX Gyre Pagella (not in Tectonic bundle)
- [2026-02-23] [flextail-whitepaper] Tectonic.toml: [[output]] preamble field must point to the full standalone .tex file (not index field)
- [2026-02-23] [flextail-whitepaper] src/ must contain only index.tex and refs.bib - any extra .tex file will be picked up as entry point
- [2026-02-23] [flextail-whitepaper] Preamble inlined into index.tex (no separate _preamble.tex file)
- [2026-02-23] [flextail-whitepaper] cleveref must load AFTER hyperref
- [2026-02-23] [flextail-whitepaper] BibTeX keys: ljungberg2004 = Burdorf/Sorock 1997; hawkins2007 = Daneshmandi 2017 (legacy naming)
- [2026-02-23] [flextail-whitepaper] PDF output: build/default/default.pdf (66.69 KiB)
- [2026-03-02] [flextail-whitepaper] Added SPINE20 2025 Cape Town policy recommendations as Tier 4 (expert consensus) citation to strengthen occupational and background arguments. Ref key: spine20_2025.

## Errors & Lessons Learned
- [2026-02-23] Tectonic -X build scans src/ alphabetically and picks the first .tex as entry - _preamble.tex sorts before index.tex, causing "usepackage before documentclass" error. Fix: remove extra .tex files from src/ or ensure only one .tex file exists there.
- [2026-02-23] Tectonic.toml [[output]] `index` field does NOT specify the main document entry point - it inserts the file as the body within a preamble/index/postamble structure. Use `preamble` field with the full standalone document path.
- [2026-02-23] Tectonic.toml [[output]] `preamble` field path is relative to the src/ directory (not the project root). Use just "index.tex" not "src/index.tex".
- [2026-02-23] BibTeX "internal consistency problem when checking if .bbl changed" warning is benign - PDF still compiles correctly through 6 passes.
- [2026-02-23] Walkling 2025 was cited with wrong participant count (30→10), wrong activity count (14→11), wrong environment (outdoor→indoor only), and a fabricated 97%/10s window result. Always read the full paper before citing numbers.
- [2026-02-23] refs.bib `spinalMouse` DOI `10.1007/s00586-019-05921-6` resolved to wrong paper (Watanabe AIS study). DOI removed from entry; correct DOI for van der Veen 2019 Idiag M360 paper not locatable.
- [2026-02-23] refs.bib `sun2023` had wrong title, 10-wrong authors, and wrong PMID. Corrected to Weige Sun et al. meta-analysis (PMID 37124897, PMC10135498).
- [2026-02-23] conclusions.tex claimed "four published or peer-reviewed studies" but Masch in-vitro is explicitly unpublished. Fixed to "three published peer-reviewed studies and one pre-publication in-vitro validation."
- [2026-02-23] validation.tex overclaimed "not achieved by any single competing technology in the published literature." Toned down to "not demonstrated by the comparison technologies reviewed here."

## Fact-Check Session Results (2026-02-23)
Full fact-check report saved to: `src/fact_check_report.md`

### Confirmed Errors Found:
1. `limitations.tex` line 38: "30 participants" → CORRECT VALUE: **10 participants** (Walkling 2025 PMC12196833)
2. `executive_summary.tex` line 29: "14-class HAR" → CORRECT VALUE: **11 activities** (Walkling 2025)
3. `conclusions.tex` line 25–26: "across 14 daily activities" → CORRECT VALUE: **11 activities** (Walkling 2025)
4. `refs.bib` `spinalMouse` DOI `10.1007/s00586-019-05921-6` → WRONG PAPER (resolves to Watanabe AIS study). Correct DOI for van der Veen, Holewijn & Smit 2019 "Idiag M360" paper NOT FOUND.
5. `refs.bib` `sun2023` entry: wrong title (should be "Prevalence of WMSDs among Nurses: A Meta-Analysis"), wrong authors (should be Weige Sun et al.), wrong PMID (should be 37124897 not 37124926)

### Confirmed Correct (Key Claims):
- Walkling 2025: F1=0.90, standing-up 95%/76%, 10 participants, 11 activities — ALL CONFIRMED
- Sawicki 2026: 60%/44%/37%/63% reductions — ALL CONFIRMED; seven Vicon Valkyrie VK16 cameras — CONFIRMED
- Hartvigsen 2018 as leading LBP source — CONFIRMED
- Belavy 2016 disc herniation risk — CONFIRMED
- Burdorf/Sorock 1997 DOI — CONFIRMED
- Sun 2023 77.2% WMSD prevalence in nurses — CONFIRMED (despite wrong BibTeX metadata)

### Papers Fully Verified (read in this session or prior):
- Walkling 2025 (PMC12196833) — full text read
- Sawicki 2026 (doi:10.1007/s41693-025-00173-x) — abstract + methods section read
- Sun 2023 (PMC10135498) — full text read
- Belavy 2016 (doi:10.1007/s00586-015-3917-y) — abstract + open-access text read
- Hartvigsen 2018 (doi:10.1016/S0140-6736(18)30480-X) — abstract confirmed
- Burdorf/Sorock 1997 (doi:10.5271/sjweh.217) — abstract confirmed
