# Notionify

Convert Markdown files to Notion-styled PDFs using pandoc.

## Installation

1. Clone this repository.
2. Make the script executable:

```bash
chmod +x notionify.sh
```

## Usage

```bash
./notionify.sh your-file.md
```

This generates `your-file.pdf` in the current directory.

## Supported Markdown Features

- Headings (h1-h6)
- Paragraphs and emphasis
- Ordered and unordered lists
- Task lists (checkboxes)
- Blockquotes
- Code blocks and inline code
- Tables
- Callouts/admonitions
- Horizontal rules
- Links
- Images with captions

## Requirements

- `pandoc` and `wkhtmltopdf` (auto-installed by the script on macOS or Linux)

## Example Output

![Example output screenshot placeholder](docs/example-output.png)

## License

MIT
