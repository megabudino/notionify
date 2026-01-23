# PRD: Notionify

## Introduction

Notionify is a bash script that converts Markdown files to PDF with styling that replicates Notion's clean, minimal document appearance. Users specify a `.md` file in the working directory, and the script outputs a styled PDF using pandoc with a custom CSS file.

## Goals

- Convert any Markdown file to a Notion-styled PDF with a single command
- Support full Markdown feature set including checkboxes, tables, callouts, and images
- Auto-install pandoc if not present (macOS and Linux)
- Provide clear error messages for edge cases (missing file, missing argument, etc.)
- Zero configuration required after installation

## User Stories

### US-001: Basic script structure and argument handling
**Description:** As a user, I want the script to validate my input so I get helpful error messages instead of cryptic failures.

**Acceptance Criteria:**
- [ ] Script accepts exactly one argument (the markdown filename)
- [ ] Error with usage instructions if no argument provided
- [ ] Error if file doesn't exist in current directory
- [ ] Error if file is not a `.md` file
- [ ] Exit codes: 0 for success, 1 for errors
- [ ] Script is executable (`chmod +x`)

### US-002: Auto-install pandoc dependency
**Description:** As a user, I want pandoc to be installed automatically so I don't have to figure out dependencies.

**Acceptance Criteria:**
- [ ] Detect if pandoc is installed
- [ ] On macOS: install via Homebrew (install Homebrew first if needed)
- [ ] On Linux: install via apt-get (Debian/Ubuntu) or yum (RHEL/CentOS)
- [ ] Prompt user for sudo password when needed
- [ ] Informative message during installation
- [ ] Error if installation fails

### US-003: Create Notion-style CSS
**Description:** As a developer, I need a CSS file that replicates Notion's document styling for the PDF output.

**Acceptance Criteria:**
- [ ] System font stack similar to Notion (San Francisco, Segoe UI, sans-serif)
- [ ] Heading styles (h1-h6) matching Notion proportions and weights
- [ ] Paragraph spacing and line-height matching Notion
- [ ] Code blocks with monospace font and light gray background
- [ ] Inline code styling
- [ ] Blockquote styling with left border
- [ ] Table styling with borders and alternating row colors
- [ ] List styling (ordered, unordered, nested)
- [ ] Checkbox styling for task lists `- [ ]` and `- [x]`
- [ ] Callout/admonition block styling
- [ ] Horizontal rule styling
- [ ] Link styling (blue, no underline until hover)
- [ ] Image styling with captions
- [ ] Page margins appropriate for PDF

### US-004: PDF conversion workflow
**Description:** As a user, I want to run `notionify myfile.md` and get `myfile.pdf` in the same directory.

**Acceptance Criteria:**
- [ ] Output PDF has same base name as input file
- [ ] PDF is created in the current working directory
- [ ] CSS file is bundled with script or created in a known location
- [ ] Success message showing output filename
- [ ] Pandoc called with correct options for PDF generation via HTML

### US-005: Create GitHub README
**Description:** As a potential user, I want clear documentation so I can install and use the tool quickly.

**Acceptance Criteria:**
- [ ] Project title and one-line description
- [ ] Installation instructions (clone, make executable)
- [ ] Usage examples with command syntax
- [ ] Supported Markdown features list
- [ ] Requirements/dependencies section
- [ ] Example output screenshot (placeholder)
- [ ] License section

## Functional Requirements

- FR-1: Script must be named `notionify` (no extension) or `notionify.sh`
- FR-2: Accept one positional argument: the Markdown filename
- FR-3: Validate file exists and has `.md` extension
- FR-4: Auto-detect OS (macOS vs Linux) for package manager selection
- FR-5: Install pandoc automatically if not found
- FR-6: Store CSS in `~/.notionify/notion.css` for reuse
- FR-7: Generate PDF using: `pandoc input.md -t html -o output.pdf -c notion.css`
- FR-8: Support wkhtmltopdf or weasyprint as PDF engine (pandoc requirement)
- FR-9: All error messages must be user-friendly and actionable

## Non-Goals

- No GUI or interactive mode
- No batch processing of multiple files (single file per invocation)
- No custom theme options or configuration file
- No watch mode for live conversion
- No support for Windows (native, non-WSL)
- No conversion to formats other than PDF

## Technical Considerations

- CSS must work with pandoc's HTML-to-PDF pipeline
- PDF engine (wkhtmltopdf or weasyprint) needs to be installed alongside pandoc
- CSS should use `@media print` rules for PDF-specific styling
- Checkbox rendering requires pandoc's task list extension
- Consider using `--self-contained` flag for portability

## Success Metrics

- User can convert a file in under 5 seconds (excluding first-time install)
- PDF output visually matches Notion export at 90%+ fidelity
- Zero manual dependency installation required on fresh system

## Open Questions

- Should we support custom CSS overrides in the future?
- Should output directory be configurable via flag?
- Include sample markdown file for testing?
