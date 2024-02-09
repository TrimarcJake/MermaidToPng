# MermaidToPng
A micro-module for converting Mermaid-formatted Markdown files into PNGs using only Powershell and Edge.

## Basic Overview
  - Reads 

### Usage:
``` powershell
Convert-MermaidToPng -FilePath 'C:\path\to\input.md'
```
Converts the Markdown file located at `C:\path\to\input.md` to a PNG image in the same directory.

### Known Issues:
  - Requires full path to Markdown file
  - The Mermaid-formatted text must start on line 2 of the Markdown file and end on the second-to-last line.
 