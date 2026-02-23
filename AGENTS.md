# Whitepaper Automation System - Opencode Orchestration

## Architecture

This system uses opencode's `task` tool to orchestrate specialized agents through a multi-stage whitepaper production pipeline. Each whitepaper is deeply grounded in primary literature - every claim must be sourced to a paper that has been read in full.

A shared `MEMORY.md` file (at the repo root) persists cross-session knowledge: decisions made, papers already read, Strapi document IDs, and lessons learned. Every agent reads it on start and appends to it after completing their stage.

## Agent Definitions

All agent definitions are stored in `.opencode/agents/`:
- `strategist.md` - Research Scope and Argument Architecture
- `researcher.md` - Literature Review and Evidence Gathering (reads papers, tracks progress)
- `writer.md` - Technical Prose for whitepapers
- `editor.md` - Rigour Check and Fact-Verifier
- `seo_optimizer.md` - Technical SEO and Metadata (for web publication)

## Memory File

**`MEMORY.md`** (repo root) is the shared long-term memory across all sessions and agents.

### Structure

```markdown
# Whitepaper Memory

## Completed Whitepapers
| Slug | Stage | Strapi ID | Last Updated |
|------|-------|-----------|--------------|

## Papers Already Read
| ArXiv ID / DOI | Title | Saved To | Notes |
|----------------|-------|----------|-------|

## Key Decisions
- [YYYY-MM-DD] [slug] Decision description

## Errors & Lessons Learned
- [YYYY-MM-DD] Error description and how it was resolved
```

### Memory Protocol

**Every agent MUST:**
1. Read `MEMORY.md` at the start of their task
2. Check "Papers Already Read" before fetching any paper (avoid re-reading)
3. Check "Completed Whitepapers" to understand current pipeline state
4. Append their findings/decisions to `MEMORY.md` after completing their stage

**Do not overwrite** existing entries - always append.

## Folder Structure (Per Whitepaper)

Give each whitepaper a unique slug and use it throughout the process.

```
content/[slug]/
├── 01_strategy/
│   └── blueprint.md          # Argument structure, target claims, required evidence
├── 02_research/
│   ├── sources.md             # Sources catalog (if Zotero unavailable)
│   └── findings.md            # Extracted evidence, quotes, statistics
├── 03_drafts/
│   ├── draft.md               # First full prose draft (markdown)
│   └── draft_edited.md        # After rigour check (markdown)
├── 04_latex/
│   ├── Tectonic.toml          # Tectonic project config
│   ├── src/
│   │   ├── index.tex          # Main document entry point
│   │   ├── _preamble.tex      # Package imports and document setup
│   │   └── refs.bib           # BibTeX bibliography
│   └── build/                 # Tectonic output (PDF lives here)
├── 04_final/
│   └── post_ready.md          # Final with SEO frontmatter (for Strapi/web)
└── .progress.json             # Session progress tracking (CRITICAL)
```

## Workflow Pipeline

| Stage | Agent | Input | Output | Location |
|-------|-------|-------|--------|----------|
| 1 | Strategist | Topic | Blueprint | `content/[slug]/01_strategy/blueprint.md` |
| 2 | Researcher | Blueprint | Findings + Sources | `content/[slug]/02_research/` |
| 3 | Writer | Blueprint + Findings | Draft (markdown) | `content/[slug]/03_drafts/draft.md` |
| 4 | Editor | Draft + Research | Edited (markdown) | `content/[slug]/03_drafts/draft_edited.md` |
| 4b | Writer | Edited Draft | LaTeX source + PDF | `content/[slug]/04_latex/` |
| 5 | SEO Optimizer | Edited Draft | Final + Strapi | `content/[slug]/04_final/post_ready.md` |

## Quick Start - Run Single Whitepaper Pipeline

```bash
# Stage 1: Strategist (generates session_id)
task(subagent_type="strategist", description="Create whitepaper blueprint", prompt="...")

# Stage 2: Researcher (use same session_id)
task(subagent_type="researcher", description="Find and read research papers", prompt="...", task_id="ses_xxx")

# Stage 3: Writer (use same session_id)
task(subagent_type="writer", description="Write whitepaper draft", prompt="...", task_id="ses_xxx")

# Stage 4: Editor (use same session_id)
task(subagent_type="editor", description="Rigour check and polish", prompt="...", task_id="ses_xxx")

# Stage 4b: Writer - LaTeX + PDF (use same session_id)
task(subagent_type="writer", description="Convert edited draft to LaTeX and compile PDF", prompt="...", task_id="ses_xxx")

# Stage 5: SEO + Publish (use same session_id)
task(subagent_type="seo_optimizer", description="Add SEO and publish to Strapi", prompt="...", task_id="ses_xxx")
```

## Running Multiple Whitepapers in Parallel

Each whitepaper gets its own session. Start all strategist agents first, then chain each through the pipeline independently:

```bash
# Whitepaper 1
task(subagent_type="strategist", description="WP1 blueprint", prompt="...")
# → Gets task_id: ses_wp1_xxx

task(subagent_type="researcher", description="WP1 research", prompt="...", task_id="ses_wp1_xxx")
task(subagent_type="writer", description="WP1 write", prompt="...", task_id="ses_wp1_xxx")

# Whitepaper 2 (independent pipeline)
task(subagent_type="strategist", description="WP2 blueprint", prompt="...")
# → Gets task_id: ses_wp2_xxx

task(subagent_type="researcher", description="WP2 research", prompt="...", task_id="ses_wp2_xxx")
```

## Progress Tracking

**Every agent must update `.progress.json` after completing their stage:**

```json
{
  "slug": "your-whitepaper-slug",
  "stage": "writer",
  "steps_completed": ["strategy", "research"],
  "current_step": "drafting",
  "papers_found": 12,
  "papers_read": 12,
  "papers_saved_to_zotero": 10,
  "papers_saved_to_markdown": 2,
  "sources_file": "content/your-slug/02_research/sources.md",
  "last_updated": "2026-02-23T10:30:00Z",
  "session_resumeable": true
}
```

**Resuming Sessions:**
1. Read `MEMORY.md` to understand cross-session state
2. Read `.progress.json` to understand current pipeline state
3. Use the same `task_id` to continue the pipeline
4. Continue from where the previous agent left off

## Researcher Requirements

The Researcher agent MUST:
1. **Read `MEMORY.md` first** - skip papers already read in previous sessions
2. **Read every paper** using `arxiv-mcp-server_read_paper()` or `zotlink_get_item_pdf_text()`
3. **Track progress** in `.progress.json` (papers_found, papers_read, etc.)
4. **Save sources** to Zotero when available, or to `sources.md` when unavailable
5. **Never cite without reading** - papers must be read in full before citation
6. **Update `MEMORY.md`** after completing research: add all newly read papers to "Papers Already Read"

### Evidence Quality Standards

All evidence must meet these standards before being included in findings:

| Tier | Type | Acceptable Use |
|------|------|---------------|
| 1 | Systematic review / meta-analysis | Primary support for any major claim |
| 2 | RCT or pre-registered study | Supporting evidence |
| 3 | Observational / cohort study | Context and magnitude estimates |
| 4 | Expert consensus / white paper | Background only, clearly labelled |

- State the evidence tier explicitly in `findings.md` for each key claim
- If only Tier 3-4 evidence exists, the claim must be hedged accordingly in the draft
- Negative results and null findings must be recorded alongside positive ones

## Writer Requirements

The Writer agent produces **whitepaper-style prose**, not blog content:

- **Structure**: Executive Summary → Background → Evidence Review → Analysis → Conclusions → References
- **Citations**: Inline citations in the form `(Author et al., YEAR)` or numbered `[1]`
- **Claims**: Every non-obvious factual claim must have an inline citation pointing to `findings.md`
- **Hedging**: Use precise language - "suggests", "demonstrates", "is associated with" based on evidence tier
- **No filler**: No introductory platitudes, no "in conclusion" summaries that repeat the body
- **Length**: As long as the evidence requires. No padding to hit a word count.

The Writer also handles Stage 4b: converting the edited markdown draft into a LaTeX document compiled with Tectonic (see **LaTeX & Tectonic** section below).

## LaTeX & Tectonic

Every whitepaper must be produced as a PDF using Tectonic. This is non-negotiable - no other LaTeX engine is permitted.

### Toolchain Rules

- **ONLY** use `tectonic -X build` to compile. Never use `pdflatex`, `xelatex`, `lualatex`, or any legacy engine.
- **NEVER** install or reference TeX Live, MiKTeX, or MacTeX.
- Tectonic handles package downloads and multi-pass compilation automatically.

### Project Initialisation

```bash
# Run from content/[slug]/04_latex/
tectonic -X new .
# Then replace generated src/index.tex with the whitepaper source
```

### Tectonic.toml

```toml
[doc]
name = "[slug]"
bundle = "https://relay.fullhalfmoon.com/tlb/default/latest"

[[doc.input]]
file = "src/index.tex"
```

### Recommended Package Stack

Use the following packages in `src/_preamble.tex`:

```latex
\usepackage{fontspec}       % Modern font loading (XeTeX)
\usepackage{amsmath}        % Math environments
\usepackage{booktabs}       % Professional tables (\toprule, \midrule, \bottomrule)
\usepackage{graphicx}       % Figures
\usepackage{microtype}      % Microtypography
\usepackage{siunitx}        % Quantities and units
\usepackage[printonlyused]{acronym} % Acronym management
\usepackage{cleveref}       % Smart cross-references (\cref)
\usepackage{hyperref}       % PDF links — LOAD LAST
```

### Bibliography

Use the BibTeX workflow. Do **not** use `biblatex`/`biber`.

```latex
% In src/index.tex, at end of document:
\bibliographystyle{unsrt}
\bibliography{refs}
```

Populate `src/refs.bib` from the sources gathered in `02_research/sources.md`. Every entry cited in the LaTeX source must exist in `refs.bib`.

### Document Structure (`src/index.tex`)

```latex
\input{_preamble}
\begin{document}

\title{Whitepaper Title}
\author{Author}
\date{\today}
\maketitle

\begin{abstract}
  Executive summary paragraph.
\end{abstract}

\tableofcontents

\section{Background}
\section{Evidence Review}
\section{Analysis}
\section{Conclusions}

\bibliographystyle{unsrt}
\bibliography{refs}

\end{document}
```

### Compilation

```bash
# From content/[slug]/04_latex/
tectonic -X build
# PDF output: content/[slug]/04_latex/build/[slug].pdf
```

If the build fails, read the Tectonic error output carefully - it is precise. Fix the LaTeX source and re-run. Do not switch engines.

### Progress Tracking for LaTeX Stage

After successful compilation, update `.progress.json`:

```json
{
  "latex_source": "content/[slug]/04_latex/src/index.tex",
  "pdf_output": "content/[slug]/04_latex/build/[slug].pdf",
  "latex_compiled": true
}
```



## Editor (Rigour Check) Requirements

The Editor must verify:
1. **Every claim** maps to a source in `findings.md` - flag any unsourced claims
2. **Evidence tier** is appropriate for the strength of the claim
3. **No overclaiming** - conclusions do not exceed what the evidence supports
4. **No underclaiming** - strong evidence is presented with appropriate confidence
5. **Internal consistency** - no contradictions between sections
6. **Citation format** is uniform throughout
7. Update `MEMORY.md` with any major corrections or lessons learned

## Standards

- **Tone**: Precise, measured, authoritative - no marketing language, no "AI smell"
- **Science**: 100% verified via researcher tools - no unverified citations
- **Evidence**: Claims scaled to evidence tier - no overclaiming
- **Verification**: All claims must be tool-verified before output
- **Reading**: Every cited paper must be read in full
- **Memory**: All agents read and update `MEMORY.md`

## Content Structure

**CRITICAL:** The `content` field must NOT start with the title as a heading. The title is stored separately in Strapi.

**Correct structure:**
```markdown
**Executive Summary**

One paragraph summary of the whitepaper's main finding and its significance.

---

## Background

## Evidence Review

## Analysis

## Conclusions

## References
```

**Incorrect (DO NOT DO THIS):**
```markdown
# Whitepaper Title  ← DON'T DO THIS

Executive Summary...
```

## Anti-AI-Smell Guidelines

**Forbidden phrases (never use):**
- "delve into" / "tief in die Materie eintauchen"
- "tapestry" / "komplexes Geflecht"
- "explore the depths" / "sich vertiefen"
- "ever-evolving" / "implication"
- "in the world of" / "in der Welt von"
- Explicit claims of scientific authority in titles (e.g. "A scientific guide", "Scientifically proven") - the evidence speaks for itself

**Use instead:**
- Short, declarative sentences
- Specific numbers and effect sizes from the papers
- Named studies: "The 2022 RECOVERY trial showed..."
- Direct language: state what the evidence shows, not what you are about to show

## Titles & Subtitles

- Do not assert scientific authority in titles. Evidence belongs in the body and citations, not the headline.
- Prefer neutral, precise wording: "The Effect of X on Y" not "The Definitive Scientific Guide to X"
- `title_tag` and frontmatter `title` must not contain phrases like "scientifically proven", "evidence-based guide", etc.

## File Naming Convention

- Memory: `MEMORY.md` (repo root, shared across all whitepapers)
- Progress: `content/[slug]/.progress.json`
- Blueprints: `content/[slug]/01_strategy/blueprint.md`
- Sources: `content/[slug]/02_research/sources.md` (or Zotero)
- Research: `content/[slug]/02_research/findings.md`
- Drafts: `content/[slug]/03_drafts/draft.md` / `draft_edited.md`
- LaTeX: `content/[slug]/04_latex/src/index.tex`
- Bibliography: `content/[slug]/04_latex/src/refs.bib`
- PDF: `content/[slug]/04_latex/build/[slug].pdf`
- Final: `content/[slug]/04_final/post_ready.md`

## Strapi CMS Integration

### Reading Existing Articles
Before creating new content, read existing articles to maintain voice consistency:
```bash
strapi_list_entries(content_type="articles", page=1, page_size=20, sort="createdAt:desc")
```
Review 3-5 recent articles to understand current tone, structure, and style.

### Publishing New Articles

**CRITICAL: Create one article with two locales - not two separate articles.**

The SEO Optimizer (Stage 5) must:
1. Read `MEMORY.md` to check if this whitepaper was previously published (avoid duplicates)
2. Read the final post from `content/[slug]/04_final/post_ready.md`
3. Detect content language from the first 200 characters:
   - German indicators: "du", "deine", "der", "die", "das", "und", "für", ä, ö, ü, ß
   - English indicators: "you", "your", "the", "and", "for", "with"
4. Create the primary locale entry in Strapi using `strapi_create_entry`
5. Translate and create the second locale entry on the **same document**
6. Verify both locales with `strapi_get_entry`
7. Record both document IDs in `MEMORY.md` under "Completed Whitepapers"

**Required fields for `strapi_create_entry`:**
```json
{
  "content_type": "articles",
  "locale": "de",
  "data": {
    "title": "Whitepaper Title",
    "content": "Full markdown content",
    "slug": "url-friendly-slug",
    "excerpt": "Brief description (150-160 chars)",
    "metaTitle": "SEO title tag (50-60 chars)",
    "metaDescription": "SEO meta description (150-160 chars)",
    "publishedAt": "2026-02-23T10:00:00Z"
  }
}
```

**Required `post_ready.md` frontmatter:**
```yaml
---
title_tag: "Primary Keyword: Descriptive Subtitle"
meta_description: "Concise summary with value proposition (150-160 chars)"
slug: "primary-keyword-topic-slug"
locale: "de"
---
```

**Verification after publishing both locales:**
```bash
strapi_get_entry({ content_type: "articles", document_id: "xxx", locale: "de" })
strapi_get_entry({ content_type: "articles", document_id: "xxx", locale: "en" })
```

### Strapi Schema
- `title`: Whitepaper title
- `content`: Full markdown content
- `slug`: URL-friendly identifier
- `excerpt`: Brief description for previews (150-160 chars)
- `locale`: Language (`de`/`en`) - **CRITICAL: Must match content language**
- `metaTitle`: SEO title tag (50-60 chars)
- `metaDescription`: SEO meta description (150-160 chars)
- `publishedAt`: Publication timestamp
- `tags`: Optional array of tag strings
- `featured`: Boolean for featured articles

## Session ID Tracking

**Critical**: Use `task_id` to chain agents through the pipeline:

1. **First call**: Omit `task_id` - agent creates initial `.progress.json` and seeds `MEMORY.md`
2. **Subsequent calls**: Pass the same `task_id` to maintain session continuity
3. **Both files**: Each agent reads `.progress.json` (stage state) AND `MEMORY.md` (cross-session knowledge)

Example:
```bash
# Stage 1 - no task_id
task(subagent_type="strategist", description="Create blueprint", prompt="...")
# → Returns task_id: ses_abc123

# Stage 2 - continue session
task(subagent_type="researcher", description="Research", prompt="...", task_id="ses_abc123")

# Stage 3
task(subagent_type="writer", description="Write", prompt="...", task_id="ses_abc123")
```
