# pubs

A [Lean 4](https://lean4-lang.org/) tool that generates the publications section of an academic CV and personal website from a single source of truth.

## Overview

`pubs` reads a structured publication data file (in `.mlml` format, parsed via [mlml](https://github.com/gmcninch-tufts/mlml)) and writes two nearly-identical Markdown files:

- **`cv-manuscripts.md`** — a bibliography formatted for a CV (built
  with pandoc/Makefile).  See e.g. the last bit of
  [mcninch-cv](https://gmcninch.math.tufts.edu/assets/curriculum-vita-short.pdf)
- **`manuscripts.md`** — a publication list for my professional
  website, including a detailed section with per-paper metadata. See
  e.g. [mcninch-manuscripts](https://gmcninch.math.tufts.edu/pages/manuscripts.html)

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

For example:

``` conf

let msPDF  = "https://gmcninch.math.tufts.edu/assets/manuscripts/"

let bibtex = "https://gmcninch.math.tufts.edu/assets/manuscripts/bibtex/"

let errata = "https://gmcninch.math.tufts.edu/assets/manuscripts/errata/"

;; authors

let georgeMcNinch =  Author {
    institution = "Tufts University"
    name        = "George McNinch"
    url         = "https://gmcninch.math.tufts.edu"
  }

  MS  {
    authors   = [ georgeMcNinch ]
    citation  = Journal {
        year    = 2024
        journal = "Pacific J. Math"
        volume  = 336
        number  = "1-2"
        pages   = "379-397"
      }
    id       = "mcninch24:cohomology-levi"
    abstract = mcninch24:cohomology-levi
    urls     = [
      Local  { path      = [ msPDF  "cohomology-levi.pdf" ] }
      DOI    { doiNumber = "10.2140/pjm.2025.336.379" }
      MR     { mrNumber  = "MR4914997" }
      Bibtex { path      = [ bibtex "mcninch24:cohomology-levi.bib" ] }
      ]
    title    = "Levi decompositions of linear algebraic groups and non-abelian cohomology"
    }
	
let mcninch24:cohomology-levi = "Let $k$ be a field, and let $G$ be a linear algebraic group over $k$ for which the unipotent radical $U$ of $G$ is defined and split over $k$.  Consider a finite, separable field extension $\ell$ of $k$ and suppose that the group $G_\ell$ obtained by base-change has a *Levi decomposition* (over $\ell$). We continue here our study of the question previously investigated in (McNinch 2013): does $G$ have a *Levi decomposition* (over $k$)?	

```

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
