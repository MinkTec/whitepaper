# Whitepaper Memory

## Completed Whitepapers
| Slug | Stage | Strapi ID | Last Updated |
|------|-------|-----------|--------------|
| flextail-whitepaper | PDF compiled | N/A | 2026-02-23 |

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

## Key Decisions
- [2026-02-23] [flextail-whitepaper] Use palatino + T1 fontenc instead of fontspec/TeX Gyre Pagella (not in Tectonic bundle)
- [2026-02-23] [flextail-whitepaper] Tectonic.toml: [[output]] preamble field must point to the full standalone .tex file (not index field)
- [2026-02-23] [flextail-whitepaper] src/ must contain only index.tex and refs.bib - any extra .tex file will be picked up as entry point
- [2026-02-23] [flextail-whitepaper] Preamble inlined into index.tex (no separate _preamble.tex file)
- [2026-02-23] [flextail-whitepaper] cleveref must load AFTER hyperref
- [2026-02-23] [flextail-whitepaper] BibTeX keys: ljungberg2004 = Burdorf/Sorock 1997; hawkins2007 = Daneshmandi 2017 (legacy naming)
- [2026-02-23] [flextail-whitepaper] PDF output: build/default/default.pdf (66.69 KiB)

## Errors & Lessons Learned
- [2026-02-23] Tectonic -X build scans src/ alphabetically and picks the first .tex as entry - _preamble.tex sorts before index.tex, causing "usepackage before documentclass" error. Fix: remove extra .tex files from src/ or ensure only one .tex file exists there.
- [2026-02-23] Tectonic.toml [[output]] `index` field does NOT specify the main document entry point - it inserts the file as the body within a preamble/index/postamble structure. Use `preamble` field with the full standalone document path.
- [2026-02-23] Tectonic.toml [[output]] `preamble` field path is relative to the src/ directory (not the project root). Use just "index.tex" not "src/index.tex".
- [2026-02-23] BibTeX "internal consistency problem when checking if .bbl changed" warning is benign - PDF still compiles correctly through 6 passes.
- [2026-02-23] Walkling 2025 was cited with wrong participant count (30→10), wrong activity count (14→11), wrong environment (outdoor→indoor only), and a fabricated 97%/10s window result. Always read the full paper before citing numbers.
