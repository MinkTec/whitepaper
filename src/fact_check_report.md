# FlexTail Whitepaper — Fact-Check Report

**Generated:** 2026-02-23  
**Checked by:** Researcher Agent  
**Scope:** All 12 citations in `src/refs.bib` plus all quantitative claims in `src/sections/*.tex`

---

## Summary

Four confirmed errors were found: two factual errors in the body text, and two BibTeX metadata errors. Three additional issues are classified as unverifiable or soft citation problems. No errors were found in the key performance figures from Walkling 2025 or Sawicki 2026.

---

## Table 1 — CONFIRMED ERRORS

| # | Location | Whitepaper Claims | Correct Value | Source |
|---|----------|------------------|---------------|--------|
| 1 | `limitations.tex` line 38 | "The Walkling et al. HAR study involved **30 participants**" | **10 participants** | Walkling 2025, PMC12196833, Methods: "Ten healthy volunteers (7 males and 3 females)…" The "30" likely came from Haghi 2023 (a different paper with 30 participants, referenced in Walkling's Table 1). |
| 2 | `executive_summary.tex` line 29 | "**14-class** human activity recognition" | **11 activities** | Walkling 2025 studies exactly 11 named activities throughout: sitting down, standing up, sitting, standing, walking, loading dishwasher, unloading dishwasher, wiping table, vacuuming, eating, food cutting. No 14th class exists. |
| 3 | `conclusions.tex` line 25–26 | "activity recognition at F1 = 0.90 … across **14** daily activities" | **11 activities** | Same as Error 2 above. Same wrong number appears in two locations. |
| 4 | `refs.bib` lines 75–84 (`spinalMouse` entry) | DOI `10.1007/s00586-019-05921-6` attributed to van der Veen, Holewijn & Smit (2019), "Reproducibility and validity of the Idiag M360…" | DOI resolves to: **Watanabe et al. (2019), "Can posterior implant removal prevent device-related vertebral osteopenia after posterior fusion in adolescent idiopathic scoliosis? A mean 29-year follow-up study,"** *Eur Spine J*, 28(6):1314–1321. Completely unrelated paper (AIS bone density). | Verified by fetching https://doi.org/10.1007/s00586-019-05921-6 directly. |

---

## Table 2 — BibTeX METADATA ERRORS

| # | Location | Field | Whitepaper Value | Correct Value | Source |
|---|----------|-------|-----------------|---------------|--------|
| 5 | `refs.bib` line 137 (`sun2023` entry) | `title` | "Work-Related Musculoskeletal Disorders and Ergonomic Risk Factors in Special Education Teachers and Nurses: A Systematic Review" | **"Prevalence of Work-Related Musculoskeletal Disorders among Nurses: A Meta-Analysis"** — the paper is a meta-analysis on nurses only; there is no mention of special education teachers | PMC10135498 full text confirmed. |
| 6 | `refs.bib` lines 136–146 (`sun2023` entry) | `author` | Sun, Wei and Li, Yan and Liu, Shanshan and Zhao, Jing and Duan, Weilong and Zhang, Zhiqiang and Han, Lixia and Wang, Chao and Zhao, Xiaofang and Liu, Jian | **Weige Sun, Lishi Yin, Tianqiao Zhang, Huixin Zhang, Ran Zhang, Weixin Cai** | PMC10135498 full author list confirmed. |
| 7 | `refs.bib` line 145 (`sun2023` entry) | `note` (PMID) | PMID 37124926 | **PMID 37124897** | PubMed record for PMC10135498 confirmed. |

---

## Table 3 — CONFIRMED FACTS

| Claim | Location | Status | Verification Source |
|-------|----------|--------|---------------------|
| F1 = 0.90 at 1-second window (both FlexTail and camera baseline) | `validation.tex`, `executive_summary.tex` | ✅ CONFIRMED | Walkling 2025 (PMC12196833), Abstract and Table 2 |
| Standing-up: FlexTail 95% vs OpenPose 76% accuracy | `validation.tex`, `executive_summary.tex` | ✅ CONFIRMED | Walkling 2025, Results section |
| OpenPose 1.7.0 with 25 keypoints | `validation.tex` | ✅ CONFIRMED | Walkling 2025 Methods |
| RDST classifier for FlexTail; QUANT for camera | `validation.tex` | ✅ CONFIRMED | Walkling 2025 Methods |
| Walkling 2025: 10 participants, 11 activities, indoor only | `validation.tex` | ✅ CONFIRMED | Walkling 2025 full text |
| Geometric accuracy: 0.7 mm position MAE, 0.8° angular MAE (spine template); 1.2 mm / 1.1° (all templates) | `executive_summary.tex`, `validation.tex` | ✅ CONFIRMED | Masch et al. in-vitro data as reported in Walkling 2025 Table 1 |
| 60% reduction in time in flexed spinal postures (Sawicki 2026) | `executive_summary.tex`, `validation.tex` | ✅ CONFIRMED | Sawicki 2026, doi:10.1007/s41693-025-00173-x, abstract |
| 44% reduction in total carried weight (Sawicki 2026) | `validation.tex` | ✅ CONFIRMED | Sawicki 2026 abstract |
| 37% reduction in distance walked per task (Sawicki 2026) | `validation.tex` | ✅ CONFIRMED | Sawicki 2026 abstract |
| 63% reduction in perceived exertion (Sawicki 2026) | `validation.tex` | ✅ CONFIRMED | Sawicki 2026 abstract (Borg + NASA-TLX) |
| Heart rate and blood lactate unchanged (Sawicki 2026) | `validation.tex` | ✅ CONFIRMED | Sawicki 2026 abstract |
| **Seven Vicon Valkyrie VK16 cameras** used in Sawicki 2026 | `validation.tex` (implied by camera ref) | ✅ CONFIRMED | Sawicki 2026 full text: "motion capturing using seven Valkyrie VK16 (Vicon Motion Systems LTD, Yarnton, UK) cameras" |
| FlexTail worn inside standard shirt (Sawicki 2026) | `validation.tex` | ✅ CONFIRMED | Sawicki 2026 |
| Low back pain: leading cause of years lived with disability globally | `background.tex` | ✅ CONFIRMED | Hartvigsen et al. 2018 (Lancet), doi:10.1016/S0140-6736(18)30480-X, abstract |
| Belavy 2016: elevated disc herniation risk post-flight vs pre-flight | `applications.tex` lines 327–328 | ✅ CONFIRMED | Belavy et al. (2016), doi:10.1007/s00586-015-3917-y, abstract |
| Burdorf & Sorock 1997: lifting/carrying, WBV, bending/twisting as consistent LBP risk factors | `background.tex` | ✅ CONFIRMED | doi:10.5271/sjweh.217 confirmed valid, 35-study review |
| Sun 2023: 77.2% annual prevalence of WMSDs in nurses; lower back most affected (59.5%) | `applications.tex` | ✅ CONFIRMED | PMC10135498 full text (despite wrong BibTeX metadata) |
| Madgwick 2011 DOI valid | `background.tex`, `technology.tex`, `validation.tex` | ✅ CONFIRMED | doi:10.1109/ICORR.2011.5975346 resolves to correct IEEE ICORR paper |
| Denavit 1955 DOI valid | `technology.tex` | ✅ CONFIRMED | doi:10.1115/1.4011045 resolves to correct ASME J Applied Mechanics paper |
| "Three independent research groups and four published or peer-reviewed studies" | `conclusions.tex` line 19 | ✅ PLAUSIBLE | Groups: (1) RWTH Aachen (Walkling/Masch/Deserno), (2) TU Braunschweig (Sawicki/Düking et al.), (3) Lindenhofgruppe/Aghayev (Marx 2023). Studies: (1) Masch in-vitro, (2) Walkling 2025 HAR, (3) Sawicki 2026, (4) Marx 2023. Count is internally consistent. |

---

## Table 4 — UNVERIFIABLE CLAIMS

| Claim | Location | Issue | Recommendation |
|-------|----------|-------|----------------|
| Idiag M360 "published precision 1°–2°" | `background.tex` lines 106–108, `validation.tex` table | Cannot be verified because the cited DOI (`spinalMouse`) resolves to a completely unrelated paper. The claim itself is plausible (multiple papers discuss Idiag M360 precision in this range), but **no correct DOI could be located** for van der Veen, Holewijn & Smit 2019. PubMed search returns zero results; the title in refs.bib may be inaccurate. | **Must fix:** Locate correct DOI or replace citation with a verifiable source (e.g., the Nature Scientific Reports comparison paper at doi:10.1038/s41598-022-13891-x which also discusses Idiag M360 precision). |
| "RMSE values around 0.154 mm for Vicon" | `background.tex` line 56 (citing `vicon_rmse`) | Ehara 1995 DOI (10.1016/0966-6362(95)01047-5) appears valid and the paper is real (widely cited), but full text is inaccessible (ScienceDirect returns 404 for this old URL). The specific 0.154 mm figure cannot be verified from paper text. The "around" qualifier appropriately hedges the claim. | Low priority. Paper existence is confirmed by secondary citations. Accept with hedge. |
| Spine elongates "by several centimetres" in microgravity | `applications.tex` line 324 (citing `belavy2016`) | Belavy 2016 discusses the elongation mechanism and cites a NASA report (Young & Rajulu 2011) for the quantitative value. The actual magnitude reported in the literature is ~1.5–3 cm, which is consistent with "several centimetres." The claim is factually correct but the quantitative figure derives from a NASA source cited *within* Belavy 2016, not from Belavy 2016 directly. | Accept as written — the citation to Belavy 2016 is appropriate for the mechanism; the "several centimetres" is a defensible summary of the underlying data. |
| Marx 2023 content (ROM pre/post dorsale Korrekturspondylodese) | `validation.tex`, `applications.tex` | DOI 10.1055/s-0043-1761303 is confirmed as a real *Die Wirbelsäule* abstract (cited in Walkling 2025 reference list). Full text not accessible (conference abstract, paywalled). Claims attributed to this paper were not directly verified from paper text. | The citation is confirmed as real via cross-reference in Walkling 2025. The narrow claims (ROM measurement pre/post surgery using FlexTail) are consistent with the abstract type. Accept, note that independent verification of specific figures is not possible without full text. |

---

## Table 5 — SOFT CITATION ISSUES (Not Errors, But Worth Noting)

| Claim | Location | Issue |
|-------|----------|-------|
| "Ferromagnetic structures…introduce unbounded yaw error within minutes" cited to Madgwick 2011 | `background.tex` lines 100–102 | Madgwick 2011 presents a gradient-descent IMU fusion algorithm. It demonstrates the filter working with/without magnetometer, and notes magnetometer limitations generally. It does not specifically characterise ferromagnetic failure modes or yaw error accumulation timescales. The citation uses Madgwick 2011 as a representative IMU algorithm reference, not as a primary source for the ferromagnetic limitation claim. Technically defensible (the paper is the canonical IMU fusion reference) but the specific ferromagnetic claim would be better supported by a dedicated reference. |
| Sun 2023 cited for "musculoskeletal disorders account for a disproportionate share of sick-leave days in nursing" | `applications.tex` fig caption line 293 | Sun 2023 confirms high WMSD prevalence in nurses (77.2%) and describes WMSDs as "important causes of sick leaves." It does not quantify the *proportion* of sick-leave days attributable to WMSDs. The whitepaper's claim is a reasonable inference but slightly overstates what the paper directly proves. |

---

## Required Corrections (Priority Order)

### P1 — Must Fix Before Publication

1. **`limitations.tex` line 38:** Change "30 participants" → **"10 participants"**

2. **`executive_summary.tex` line 29:** Change "14-class human activity recognition" → **"11-activity human activity recognition"**

3. **`conclusions.tex` line 25:** Change "across 14 daily activities" → **"across 11 daily activities"**

4. **`refs.bib` `spinalMouse` entry — DOI:** The DOI `10.1007/s00586-019-05921-6` is **wrong** and points to an unrelated AIS paper. Two options:
   - **Option A:** Find the correct DOI for van der Veen, Holewijn & Smit (2019) "Reproducibility and validity of the Idiag M360…" *Eur Spine J* 28(5):1056–1063 and update `doi` field.
   - **Option B:** Replace citation with a verifiable alternative source confirming Idiag M360 precision (e.g., doi:10.1038/s41598-022-13891-x).

### P2 — Should Fix (BibTeX Accuracy)

5. **`refs.bib` `sun2023` entry — `title`:** Replace with correct title: `"Prevalence of Work-Related Musculoskeletal Disorders among Nurses: A Meta-Analysis"`

6. **`refs.bib` `sun2023` entry — `author`:** Replace with correct authors: `"Sun, Weige and Yin, Lishi and Zhang, Tianqiao and Zhang, Huixin and Zhang, Ran and Cai, Weixin"`

7. **`refs.bib` `sun2023` entry — `note`:** Change `PMID 37124926` → **`PMID 37124897`**

---

## Appendix — Verification Methodology

| Paper | Verification Method | Full Text Read? |
|-------|--------------------|----|
| Walkling 2025 (PMC12196833) | arxiv-mcp-server + PMC full text | ✅ Yes |
| Sawicki 2026 (doi:10.1007/s41693-025-00173-x) | Springer full text (open access) + abstract | ✅ Abstract + methods section |
| Hartvigsen 2018 (doi:10.1016/S0140-6736(18)30480-X) | PubMed abstract | ✅ Abstract |
| Belavy 2016 (doi:10.1007/s00586-015-3917-y) | Springer full text (open access) | ✅ Abstract + discussion |
| Sun 2023 (PMC10135498) | PMC full text | ✅ Yes |
| Burdorf & Sorock 1997 (doi:10.5271/sjweh.217) | SJWEH webpage | ✅ Abstract + summary |
| Madgwick 2011 (doi:10.1109/ICORR.2011.5975346) | DOI resolution confirmed | ⚠️ DOI only |
| Denavit 1955 (doi:10.1115/1.4011045) | DOI resolution confirmed | ⚠️ DOI only |
| Ehara 1995 (doi:10.1016/0966-6362(95)01047-5) | DOI exists; ScienceDirect 404 | ❌ Not accessible |
| spinalMouse / van der Veen 2019 | DOI resolves to wrong paper | ❌ Correct paper not found |
| Marx 2023 (doi:10.1055/s-0043-1761303) | Confirmed real via Walkling 2025 reference list | ❌ Full text not accessible |
| Haghi 2023 (doi:10.3390/s23042066) | Not directly checked in this session | ⚠️ Not verified |
