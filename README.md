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

[
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

  MS {
    authors  = [ georgeMcNinch ]
    citation = Journal {
        journal = "Algebras and Representation Theory"
        year    = 2021
        volume  = 24
        pages   = "1479-1522"
      }
    id       = "mcninch21:nilpotent-orbits-over-local-field"
    abstract = mcninch21:nilpotent-orbits-over-local-field
    urls     =
      [ Local  { path = [ msPDF "nilpotent-elements-and-reductive-subgroups-over-a-local-field.pdf" ] }
        DOI    { doiNumber = "10.1007/s10468-020-10000-2" }
        Other  { label = "AlgRepTheory"
	         url   = "https://link.springer.com/article/10.1007%2Fs10468-020-10000-2"
               }
	Other  { label = "Springer"
	         url   = "https://rdcu.be/b8AHO"
	       }
        MR     { mrNumber = "MR4340850" }
        Bibtex { path = [ bibtex "mcninch21:nilpotent-orbits-over-local-field.bib" ] }
      ]
    title    = "Nilpotent elements and reductive subgroups over a local field"
    }


]

let mcninch21:nilpotent-orbits-over-local-field = "Let $\mathcal{K}$ be a *local field* -- i.e. the field of fractions of a complete DVR $\mathscr{A}$ whose residue field $\mathcal{k}$ has characteristic $p > 0$ -- and let $G$ be a connected, absolutely simple algebraic $\mathcal{K}$-group $G$ which splits over an unramified extension of $\mathcal{K}$. We study the rational nilpotent orbits of $G$-- i.e. the orbits of $G(\mathcal{K})$ in the nilpotent elements of $\operatorname{Lie}(G)(\mathcal{K})$ -- under the assumption $p>2h-2$ where $h$ is the Coxeter number of $G$.

let mcninch24:cohomology-levi = "Let $k$ be a field, and let $G$ be a linear algebraic group over $k$ for which the unipotent radical $U$ of $G$ is defined and split over $k$.  Consider a finite, separable field extension $\ell$ of $k$ and suppose that the group $G_\ell$ obtained by base-change has a *Levi decomposition* (over $\ell$). We continue here our study of the question previously investigated in (McNinch 2013): does $G$ have a *Levi decomposition* (over $k$)?	

```

This gets parsed to a `List MS` (with two elements). In
parsing/decoding, thee `let` statements are handled in a first pass,
so the order of the let statements and the "content" is irrelevant.

## Output structure

Publication reports are exported as `Markdown` documents:

- a standard bibliography list suitable for a CV
- bibliography list with details (e.g. abstracts) suitable for
  professional website.

## Dependencies

- my fork of [lean4-markdown](https://github.com/gmcninch-prof/lean4-markdown) 
- [mlml](https://github.com/gmcninch-tufts/mlml) — config/data file parser (the `.mlml` format)

## Notes

- The project was previously called `msdata` and hosted on GitLab; the canonical home is now GitHub under the name `pubs`.
