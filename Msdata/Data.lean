import Init.System.IO
--------------------------------------------------------------------------------

import Msdata.Types

def mathManuscripts : System.FilePath := 
  "/home/george/Prof-VC/Math-manuscripts"

def msPath (dir file : System.FilePath) :=
  System.FilePath.join
    mathManuscripts
    (System.FilePath.join
      dir file)

def GeorgeMcNinch : Author :=
  {  institution := "Tufts University"
  ,  name := "George McNinch"
  ,  authorUrl := "https://gmcninch.math.tufts.edu"
  }

def PaulLevy : Author :=
  { institution := "Lancaster University"
  , name := "Paul Levy"
  , authorUrl := "http://www.maths.lancs.ac.uk/~levyp/"
  }

def DonnaTesterman : Author := 
  { institution := "École Polytechnique Fédérale de Lausanne"
  , name := "Donna M. Testerman"
  , authorUrl := "https://grtes.epfl.ch/~testerma/"
  }

def ChuckHague : Author := 
  { institution := "The McKeogh Company"
  , name := "Chuck Hague"
  , authorUrl := "https://sites.google.com/site/chuckhague/"
  }

def EricSommers : Author := 
  { institution := "University of Massachusetts Amherst"
  , name := "Eric Sommers"
  , authorUrl := "http://people.math.umass.edu/~esommers/"
  }

def JuliaHartmann : Author := 
  { institution := "University of Pennsylvania"
  , name := "Julia Hartmann"
  , authorUrl := "https://www2.math.upenn.edu/~hartmann/"
  }

def DavidHarbater : Author := 
  { institution := "University of Pennsylvania"
  , name := "David Harbater"
  , authorUrl := "https://www2.math.upenn.edu/~harbater/"
  }

--------------------------------------------------------------------------------

def local_global : IO MS := do
   let abs ← IO.FS.readFile "my-paper-data/hhm26.abstract"
   pure { authors := [ DavidHarbater, JuliaHartmann, GeorgeMcNinch ]
        , citation := Citation.PrePrint ( year := 2026 )
        , id := "hhm26"
        , abstract := Option.some abs
        , bibtex := Option.none
        , errata := Option.none
        , urls := [ UrlType.Arxiv ( arxivId := "2603.26501" ) ]
        , title := "Local-global principles for the existence of Levi factors"
        }

def cohomology_levi : IO MS :=  do
   let abs ← IO.FS.readFile  "my-paper-data/mcninch24:cohomology-levi.abstract"
   
   pure { authors := [ GeorgeMcNinch ]
        , citation := Citation.Journal
             (year := 2024)
             (journal := "Pacific J. Math")
             (volume := some 336)
             (number := some "1-2")
             (pages := some "379-397")
        , id := "mcninch24:cohomology-levi"
        , abstract := abs
        , bibtex := Option.none 
        , errata := Option.none
        , urls :=
              [ UrlType.Local
                  ( path := msPath
                      "cohomology-levi" 
                      "cohomology-levi.pdf" 
                  )
              , UrlType.MR
                  ( mrNumber := "MR4914997" ) 
              ]
        , title := "Levi decompositions of linear algebraic groups and non-abelian cohomology"
        }

def nilpotent_orbits_over_local_field : IO MS := do
   let abs ← IO.FS.readFile "my-paper-data/mcninch21:nilpotent-orbits-over-local-field.abstract"
   let bib ← IO.FS.readFile "my-paper-data/mcninch21:nilpotent-orbits-over-local-field.bib"
      
   pure { authors := [ GeorgeMcNinch ]
        , citation := Citation.Journal
            (journal := "Algebras and Representation Theory")
            (year := 2021)
            (volume := some 24)
            (number := none)
            (pages := some "1479-1522")
            
        , id := "mcninch21:nilpotent-orbits-over-local-field"
        , abstract := some abs
        , bibtex := some bib
        , errata := none
        , urls :=
          [ UrlType.Local
              ( path := msPath
                  "2021-a--Nilpotent-elements-and-reductive-subgroups-over-a-local-field" 
                  "Nilpotent-elements-and-reductive-subgroups-over-a-local-field.pdf"
              )
          , UrlType.DOI ( doiNumber := "10.1007/s10468-020-10000-2" )
          , UrlType.Other 
              ( label := "Springer" ) 
              ( url := "https://rdcu.be/b8AHO" )
          , UrlType.Other
              ( label := "Journal" )
              ( url := "https://link.springer.com/article/10.1007%2Fs10468-020-10000-2" )
          , UrlType.MR (mrNumber := "MR4340850" )
          ]
        , title := "Nilpotent elements and reductive subgroups over a local field"
        }


def reductive_subgroup_schemes : IO MS :=  do
    let abs ← IO.FS.readFile "my-paper-data/mcninch20:reductive-subgroup-schemes.abstract"
    let bib ← IO.FS.readFile "my-paper-data/mcninch20:reductive-subgroup-schemes.bib"

    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               (journal := "Transformation Groups")
               (year := 2020)
               (volume := some 25)
               (number := some "1")
               (pages := some "217-249")
         , id := "mcninch20:reductive-subgroup-schemes"
         , abstract := some abs
         , bibtex := some bib
         , errata := some "2025-10-12--reductive-subgroups-fix.pdf"
         , urls :=
           [ UrlType.Local
               ( path := msPath
                   "2020-a--Reductive-subgroups-of-a-parahoric-group-scheme"
                   "Reductive subgroups of a parahoric group scheme.pdf"
               )
           , UrlType.MR ( mrNumber := "MR4070108" )
           , UrlType.DOI ( doiNumber := "10.1007/s00031-018-9508-3" )
           , UrlType.Other (label := "Journal") (url := "https://rdcu.be/bb6vn" )
           ]
         , title := "Reductive subgroup schemes of a parahoric group scheme"
         }

def central_subalgebras : IO MS := do
    let abs ← IO.FS.readFile "my-paper-data/mcninch16:MR3477055.abstract"
    let bib ← IO.FS.readFile "my-paper-data/mcninch16:MR3477055.bib"
    
    pure { authors := [ GeorgeMcNinch, DonnaTesterman ]
         , citation :=
             Citation.Journal
               (journal := "Proceedings of the American Mathematical Society")
               (year := 2016)
               (volume := some 144)
               (number := some "6")
               (pages := some "2383--2397")
         , id := "mcninch16:MR3477055"
         , abstract := some abs
         , bibtex := some bib
         , errata := none
         , urls :=
           [ UrlType.Local
               ( path := msPath
                   "2016-a--Central-subalgebras-of-the-centralizer-of-a-nilpotent-element" 
                   "McNinch and Testerman - Central subalgebras - Proc AMS final.pdf" 
               )
           , UrlType.MR ( mrNumber := "MR3477055" )
           , UrlType.DOI ( doiNumber := "10.1090/proc/12942" )
           ]
         , title := "Central subalgebras of the centralizer of a nilpotent element"
         }


def linearity : IO MS := do
    let abs ← IO.FS.readFile "my-paper-data/mcninch14:MR3181732.abstract"
    let bib ← IO.FS.readFile "my-paper-data/mcninch14:MR3181732.bib"
    
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               (journal := "Journal of Algebra")
               (volume := some 397)
               (year := 2014)
               (pages := some "666--688")
               (number := none)
         , id := "mcninch14:MR3119244"
         , abstract := some abs
         , bibtex := some bib
         , errata := none 
         , urls :=
           [ UrlType.Local
               ( path := msPath
                   "2014-b--Linearity-for-actions-on-vector-groups" 
                   "Linearity for actions on vector groups - 2013 09.pdf"
               )
           , UrlType.MR ( mrNumber := "MR3119244" )
           , UrlType.DOI ( doiNumber := "10.1016/j.jalgebra.2013.08.030" )
           ]
         , title := "Linearity for actions on vector groups"
         }

def levi_special_fiber_parahoric : IO MS := do
    let abs ← IO.FS.readFile "my-paper-data/mcninch14:MR3181732.abstract"
    let bib ← IO.FS.readFile "my-paper-data/mcninch14:MR3181732.bib"

    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               (journal := "Algebras and Representation Theory")
               (volume := some 17)
               (year := 2014)
               (number := some "2")
               (pages := some "469--479")
         , id := "mcninch14:MR3181732"
         , abstract := some abs
         , bibtex := some bib
         , errata := none
         , urls :=
           [ UrlType.Local
               ( path := msPath
                   "2014-a--Levi-factors-of-special-fiber-of-parahoric-and-tame-ramification"
                   "2013 01 - Levi factors of special fiber of parahoric and tame ramification.pdf"
               )
          , UrlType.MR ( mrNumber := "MR3181732" )
          , UrlType.DOI ( doiNumber := "10.1007/s10468-013-9404-4" )
          ]
         , title :=
            "Levi factors of the special fiber of a parahoric group scheme and tame ramification"
        }

def descent_levi_factors : IO MS := do
    let abs ← IO.FS.readFile "my-paper-data/mcninch13:MR3009659.abstract"
    let bib ← IO.FS.readFile "my-paper-data/mcninch13:MR3009659.bib"

    pure { authors := [ GeorgeMcNinch ]
         , citation :=
           Citation.Journal
             ( journal := "Archiv der Mathematik")
             (volume := some 100)
             (year := 2013)
             (number := some "1")
             (pages := some "7--24")
         , id := "mcninch13:MR3009659"
         , abstract := some abs
         , bibtex := some bib
         , errata := none
         , urls :=
           [ UrlType.Local
               ( path := msPath
                   "2013-a--On-the-descent-of-Levi-factors"
                   "On the descent of Levi factors.pdf"
               )
           , UrlType.MR ( mrNumber := "MR3009659" )
           , UrlType.DOI ( doiNumber := "10.1007/s00013-012-0467-y" )
           ]
         , title := "On the descent of Levi factors"
         }

def good_filtration_subgroups :  IO MS := do
    let abs ← IO.FS.readFile "my-paper-data/hague13:MR3057320.abstract"
    let bib ← IO.FS.readFile "my-paper-data/hague13:MR3057320.bib"

    pure { authors:= [ ChuckHague, GeorgeMcNinch ]
         , citation:=
             Citation.Journal
               ( journal:= "Journal of Pure and Applied Algebra")
               ( volume:= some 217)
               ( year:= 2013)
               ( number:= some "12")
               ( pages:= some "2400--2413")
         , id:= "hague13:MR3057320"
         , abstract:= some abs
         , bibtex:= some bib
         , errata:= none
         , urls:=
           [ UrlType.Local
               ( path:= msPath
                   "2013-b--some-good-filtration-subgroups-of-simple-algebraic-groups"
                   "some good-filtration subgroups of simple algebraic groups - 2012 05.pdf"
               )
           , UrlType.MR ( mrNumber:= "MR3057320" )
           , UrlType.Arxiv ( arxivId:= "1205.1719" )
           , UrlType.DOI ( doiNumber:= "10.1016/j.jpaa.2013.04.005" )
           ]
         , title:= "Some good-filtration subgroups of simple algebraic groups"
         }

def levi_decompositions :  IO MS := do
    let abs ← IO.FS.readFile "my-paper-data/mcninch10:MR2753264.abstract"
    let bib ← IO.FS.readFile "my-paper-data/mcninch10:MR2753264.bib"
    pure { authors:= [ GeorgeMcNinch ]
         , citation:=
             Citation.Journal
               ( journal:= "Transformation Groups")
               ( volume:= some 15)
               ( year:= 2010)
               ( number:= some "4")
               ( pages:= some "937--964")
         , id:= "mcninch10:MR2753264"
         , abstract:= some abs
         , bibtex:= some bib
         , errata:= some "Errata-Levi-decompositions.pdf"
         , urls:=
           [ UrlType.Local
               ( path:= msPath
                   "2010-a--Levi-decompositions-of-a-linear-algebraic-group"
                   "Levi decompositions of a linear algebraic group.pdf"
               )
           , UrlType.MR ( mrNumber:= "MR2753264" )
           , UrlType.DOI ( doiNumber:= "10.1007/s00031-010-9111-8" )
           , UrlType.Arxiv ( arxivId:= "1007.2777" )
           ]
         , title:= "Levi decompositions of a linear algebraic group"
         }

def nilpotent_centralizers : IO MS := do
    let abs ← IO.FS.readFile "my-paper-data/mcninch09:MR2497582.abstract"
    let bib ← IO.FS.readFile "my-paper-data/mcninch09:MR2497582.bib"
    pure { authors := [ GeorgeMcNinch, DonnaTesterman ]
         , citation:=
             Citation.Journal
               ( journal := "Journal of Pure and Applied Algebra" )
               ( volume := some 213 )
               ( year := 2009 )
               ( number := some "7" )
               ( pages := some "1346--1363" )
         , id:= "mcninch09:MR2497582"
         , abstract := some abs
         , bibtex := some bib
         , errata := none
         , urls:=
           [ UrlType.Local
               ( path:= msPath
                   "2009-a--Nilpotent-Centralizers-and-Springer-Isomorphisms"
                   "Nilpotent Centralizers and Springer Isomorphisms.pdf"
               )
           , UrlType.MR ( mrNumber:= "MR2497582" )
           , UrlType.DOI ( doiNumber:= "10.1016/j.jpaa.2008.12.007" )
           , UrlType.Arxiv ( arxivId:= "0805.2574" )
           ]
         , title:= "Nilpotent centralizers and Springer isomorphisms"
         }



def mss : IO (List MS) := do
    pure [ ← local_global
         , ← cohomology_levi
         , ← nilpotent_orbits_over_local_field
         , ← reductive_subgroup_schemes
         , ← central_subalgebras
         , ← linearity
         , ← levi_special_fiber_parahoric
         , ← descent_levi_factors
         , ← good_filtration_subgroups
         , ← levi_decompositions
         , ← nilpotent_centralizers
         ]

