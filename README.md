# Feiyang Personal Website

This repository contains the source for Feiyang Wu's personal website (Typst + Tufted).

## Quick Start

1. Activate your conda environment (recommended: Profile)
2. Build the site

   python build.py build

3. Start local preview

   python build.py preview

Default local URL: http://localhost:8000

## Common Commands

- Build: python build.py build
- Force rebuild: python build.py build -f
- Preview: python build.py preview
- Custom port: python build.py preview -p 12345

For live reload support, install in the active environment:

uv pip install livereload

## Project Structure

- content/: Website content
- config.typ: Global site config
- build.py: Build script
- assets/: Static assets (CSS/JS)
- tufted-lib/: Tufted style/layout library

## Archived Template READMEs

- docs/README.template.zh.md
- docs/README.template.en.md
