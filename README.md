# pubs

A [Lean 4](https://lean4-lang.org/) tool that generates the publications section of an academic CV and personal website from a single source of truth.

## Overview

`pubs` reads a structured publication data file (in `.mlml` format, parsed via [mlml](https://github.com/gmcninch-tufts/mlml)) and writes two nearly-identical Markdown files:

- **`cv-manuscripts.md`** — a bibliography formatted for a CV (built with pandoc/Makefile)
- **`manuscripts.md`** — a publication list for a Hakyll-based personal website, including a detailed section with per-paper metadata

Both outputs are written directly into their respective downstream repositories. Because git tracks content hashes, regenerating with no publication changes produces no spurious diffs.

## Usage

```
pubs <pubfile.mlml>
```

For example:

```
pubs data/publications.mlml
```

This writes the two Markdown outputs to the configured target directories.

## Building and installing

```sh
lake build
cp .lake/build/bin/pubs ~/.local/bin/

# or

make 
make install
```

## Data model

Publications are encoded as `MS` records in the `.mlml` format. Each record includes:

- Authors (with support for filtering/excluding specific names, e.g. your own)
- Title, journal/venue, year
- URLs with typed constructors: `DOI`, `MR`, `Arxiv`, `Euclid`, `Local`, `Other`, `Errata`, `Bibtex`

URLs are sorted by type using a `rank`-based ordering before output, so links appear in a consistent priority order (e.g. DOI first, errata last).

## Output structure

### CV output (`cvBiblio`)

Produces a standard bibliography list. Author names matching a supplied exclusion list (e.g. `["McNinch"]`) are suppressed to avoid redundancy in a personal CV context.

### Web output (`webBiblio` + `webDetails`)

Produces two sections:
1. A bibliography list
2. A per-paper detail section (under an `# Manuscript Details` heading), with full metadata including all typed URLs

YAML front matter (author, title) is prepended for Hakyll processing.

## Target directories

Each report (`MSReport`) specifies one or more `targetDirs`. On each run, the generated Markdown is written to all of them. Current targets:

| Report | Targets                                 |
|--------|-----------------------------------------|
| CV     | `results/`, `~/Prof-VC/cv-and-ms/`      |
| Web    | `results/`, `~/Web-hakyll/prof/assets/` |

## Dependencies

- my fork of [lean4-markdown](https://github.com/gmcninch-prof/lean4-markdown) 
- [mlml](https://github.com/gmcninch-tufts/mlml) — config/data file parser (the `.mlml` format)

## Notes

- The project was previously called `msdata` and hosted on GitLab; the canonical home is now GitHub under the name `pubs`.
