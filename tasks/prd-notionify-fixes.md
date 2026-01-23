# PRD: Notionify Script & CSS Fixes

## Introduction

Fix two major issues with notionify: (1) the script tries to install `wkhtmltopdf` which no longer has a Homebrew formula, and (2) the CSS produces poor PDF output with harsh contrasts and broken code blocks. The goal is a reliable markdown-to-PDF tool that produces Notion-like documents.

## Goals

- Remove broken `wkhtmltopdf` dependency, use Pandoc's native PDF generation
- Match Notion's light theme aesthetic (softer grays, warmer tones)
- Fix code block rendering (syntax highlighting, wrapping, backgrounds)
- Produce professional, readable PDFs without manual intervention

## User Stories

### US-001: Remove wkhtmltopdf dependency
**Description:** As a user, I want the script to work without installing unavailable dependencies so that I can generate PDFs immediately.

**Acceptance Criteria:**
- [ ] Remove `wkhtmltopdf` from dependency checks
- [ ] Use Pandoc's built-in PDF engine (same as user's manual command: `pandoc file.md -t html -o file.pdf -c style.css`)
- [ ] Script runs successfully on a fresh macOS system with only Pandoc installed
- [ ] Clear error message if Pandoc is missing

### US-002: Soften color palette to match Notion light theme
**Description:** As a user, I want the PDF colors to feel like Notion's light theme so the output looks professional and easy to read.

**Acceptance Criteria:**
- [ ] Text color softened (Notion uses `#37352f`, not harsh black)
- [ ] Muted text uses Notion's `#787774`
- [ ] Background remains white (`#ffffff`)
- [ ] Borders use Notion's subtle `#e9e9e7`
- [ ] Code background uses warm gray (`#f7f6f3`)
- [ ] Overall feel matches Notion's warm, low-contrast aesthetic

### US-003: Fix code block rendering
**Description:** As a user, I want code blocks to render correctly in PDFs so that code is readable and properly styled.

**Acceptance Criteria:**
- [ ] Inline code has proper padding and background visible in PDF
- [ ] Code blocks have consistent background color
- [ ] Long lines wrap or scroll appropriately (no overflow/cutoff)
- [ ] Monospace font renders correctly
- [ ] Basic syntax highlighting colors if supported by Pandoc

### US-004: Improve code block overflow handling
**Description:** As a user, I want long code lines to be handled gracefully so nothing gets cut off in the PDF.

**Acceptance Criteria:**
- [ ] `overflow-wrap: break-word` or similar applied to pre/code
- [ ] `white-space: pre-wrap` to allow wrapping in code blocks
- [ ] No horizontal scrollbars in PDF output (PDFs can't scroll)

### US-005: Polish typography for Notion-like feel
**Description:** As a user, I want the typography to feel like Notion so the document looks cohesive and modern.

**Acceptance Criteria:**
- [ ] Use system font stack similar to Notion (already using `-apple-system` which is good)
- [ ] Heading weights and sizes feel balanced
- [ ] Line height comfortable for reading (1.5-1.6)
- [ ] Blockquote styling subtle and warm

## Functional Requirements

- FR-1: Script must not attempt to install `wkhtmltopdf`
- FR-2: Script must use `pandoc` command matching user's working example
- FR-3: CSS `--notion-text` must be `#37352f` (Notion's actual text color)
- FR-4: CSS `--notion-muted` must be `#787774`
- FR-5: CSS `--notion-border` must be `#e9e9e7`
- FR-6: CSS `--notion-code-bg` must be `#f7f6f3`
- FR-7: Code blocks must use `white-space: pre-wrap` and `word-break: break-word`
- FR-8: CSS must work in Pandoc's HTML-to-PDF pipeline

## Non-Goals

- No dark theme support
- No syntax highlighting beyond Pandoc's defaults
- No custom font embedding (use system fonts only)
- No changes to CLI interface or arguments

## Technical Considerations

- Pandoc generates PDF via HTML intermediate; CSS must be PDF-print friendly
- `@media print` rules should ensure clean PDF output
- Avoid CSS features not supported in PDF rendering (e.g., `var()` may have issues in some engines—test thoroughly)
- The `-c` flag embeds CSS as a `<link>`, ensure path resolution works

## Success Metrics

- `./notionify.sh test.md` completes without errors on fresh macOS
- Generated PDF visually resembles Notion's light theme
- Code blocks are fully readable with no cutoff text
- No harsh black/white contrasts

## Open Questions

- Should we fall back to HTML output if PDF generation fails?
- Should inline CSS be used instead of external file for better compatibility?
