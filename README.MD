# MermaidToPng
A micro-module for converting Mermaid-formatted Markdown files into PNGs using only Powershell and Edge.

## Basic Overview
  - Reads a Mermaid-formatted Markdown file
  - Creates a tiny HTML file that includes the Mermaid javascript and the Mermaid-formatted Markdown
  - Opens the tiny HTML in a headless instance of Edge, takes a screenshot of the Mermaid chart, and saves it as a PNG
  - Checks the screenshot to ensure there is whitespace all around the image
  - If there isnt whitespace all around the image, expand the Edge viewing area
  - Crops all unnecessary whitespace

### Usage:
``` powershell
Convert-MermaidToPng -FilePath 'C:\path\to\input.md'
```
Converts the Markdown file located at `C:\path\to\input.md` to a PNG image in the same directory.

### Known Issues:
  - Requires full path to Markdown file
  - The Mermaid-formatted text must start on line 2 of the Markdown file and end on the second-to-last line.
 