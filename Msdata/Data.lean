import Init.System.IO
--------------------------------------------------------------------------------

import Msdata.Types

def msPDFPath (file : String) : String :=
  String.intercalate "/"
  [ "https://gmcninch.math.tufts.edu"
  , "assets/manuscripts"
  , file
  ]

def abstractPath (file : String) : System.FilePath :=
  "my-paper-data" ++ file

def bibtexPath (file :String) : String :=
  String.intercalate "/"
  [ "https://gmcninch.math.tufts.edu"
  , "assets/manuscripts/bibtex"
  , file
  ]

def errataPath (file : String) : String :=
  String.intercalate "/"
  [ "https://gmcninch.math.tufts.edu"
  , "assets/manuscripts/errata"
  , file
  ]
 
def getAbstract (file : System.FilePath) : IO String := do
  let absDir : System.FilePath := "my-paper-data"
  let abs <- IO.FS.readFile $ System.FilePath.join absDir file
  pure abs
--------------------------------------------------------------------------------

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
  --, authorUrl := "https://grtes.epfl.ch/~testerma/"
  , authorUrl := "https://people.epfl.ch/donna.testerman?lang=en"
  }

def ChuckHague : Author := 
  { --institution := "The McKeogh Company"
    institution := "PBGC"
  , name := "Chuck Hague"
  , authorUrl := "https://sites.google.com/site/chuckhague/"
  }

def EricSommers : Author := 
  { institution := "University of Massachusetts Amherst"
  , name := "Eric Sommers"
  , authorUrl := "https://sites.google.com/view/ericsommers1/home"
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
   let abs ← getAbstract "hhm26.abstract"
   pure { authors := [ DavidHarbater, JuliaHartmann, GeorgeMcNinch ]
        , citation := Citation.PrePrint ( year := 2026 )
        , id := "hhm26"
        , abstract := Option.some abs
        , urls := [ UrlType.Arxiv ( arxivId := "2603.26501" ) ]
        , title := "Local-global principles for the existence of Levi factors"
        }

def cohomology_levi : IO MS :=  do
   let abs ← getAbstract  "mcninch24:cohomology-levi.abstract"   
   pure { authors := [ GeorgeMcNinch ]
        , citation := Citation.Journal
             (year := 2024)
             (journal := "Pacific J. Math")
             (volume := some 336)
             (number := some "1-2")
             (pages := some "379-397")
        , id := "mcninch24:cohomology-levi"
        , abstract := abs
        , urls :=
              [ UrlType.Local
                  ( path := msPDFPath "cohomology-levi.pdf" )
              , UrlType.MR
                  ( mrNumber := "MR4914997" ) 
              , UrlType.Bibtex
                  ( path := bibtexPath "mcninch24:cohomology-levi.bib"
                  )
              ]
        , title := "Levi decompositions of linear algebraic groups and non-abelian cohomology"
        }

def nilpotent_orbits_over_local_field : IO MS := do
   let abs ← getAbstract "mcninch21:nilpotent-orbits-over-local-field.abstract"
      
   pure { authors := [ GeorgeMcNinch ]
        , citation := Citation.Journal
            (journal := "Algebras and Representation Theory")
            (year := 2021)
            (volume := some 24)
            (number := none)
            (pages := some "1479-1522")
            
        , id := "mcninch21:nilpotent-orbits-over-local-field"
        , abstract := some abs
        , urls :=
          [ UrlType.Local
              ( path := msPDFPath "nilpotent-elements-and-reductive-subgroups-over-a-local-field.pdf"
              )
          , UrlType.DOI ( doiNumber := "10.1007/s10468-020-10000-2" )
          , UrlType.Other 
              ( label := "Springer" ) 
              ( url := "https://rdcu.be/b8AHO" )
          , UrlType.Other
              ( label := "Journal" )
              ( url := "https://link.springer.com/article/10.1007%2Fs10468-020-10000-2" )
          , UrlType.MR (mrNumber := "MR4340850" )
          , UrlType.Bibtex 
              (path := bibtexPath "mcninch21:nilpotent-orbits-over-local-field.bib"
              )
          ]
        , title := "Nilpotent elements and reductive subgroups over a local field"
        }


def reductive_subgroup_schemes : IO MS :=  do
    let abs ← getAbstract "mcninch20:reductive-subgroup-schemes.abstract"

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
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath "reductive-subgroups-of-a-parahoric-group-scheme.pdf" )
           , UrlType.MR ( mrNumber := "MR4070108" )
           , UrlType.DOI ( doiNumber := "10.1007/s00031-018-9508-3" )
           , UrlType.Other (label := "Journal") (url := "https://rdcu.be/bb6vn" )
           , UrlType.Bibtex ( path := bibtexPath "mcninch20:reductive-subgroup-schemes.bib" )           
           , UrlType.Errata (path := errataPath "2025-10-12--reductive-subgroups-fix.pdf")
           ]
         , title := "Reductive subgroup schemes of a parahoric group scheme"
         }

def central_subalgebras : IO MS := do
    let abs ← getAbstract "mcninch16:MR3477055.abstract"
    
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
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath "mcninch-and-testerman---central-subalgebras---proc-ams-final.pdf")
           , UrlType.MR ( mrNumber := "MR3477055" )
           , UrlType.DOI ( doiNumber := "10.1090/proc/12942" )
           , UrlType.Bibtex ( path := bibtexPath "mcninch16:MR3477055.bib" )
           ]
         , title := "Central subalgebras of the centralizer of a nilpotent element"
         }


def linearity : IO MS := do
    let abs ← getAbstract "mcninch14:MR3181732.abstract"
    
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
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath "linearity-for-actions-on-vector-groups---2013-09.pdf" )
           , UrlType.MR ( mrNumber := "MR3119244" )
           , UrlType.DOI ( doiNumber := "10.1016/j.jalgebra.2013.08.030" )
           , UrlType.Bibtex ( path := bibtexPath "mcninch14:MR3181732.bib" )
           ]
         , title := "Linearity for actions on vector groups"
         }

def levi_special_fiber_parahoric : IO MS := do
    let abs ← getAbstract "mcninch14:MR3181732.abstract"

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
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath "2013-01---levi-factors-of-special-fiber-of-parahoric-and-tame-ramification.pdf")
          , UrlType.MR ( mrNumber := "MR3181732" )
          , UrlType.DOI ( doiNumber := "10.1007/s10468-013-9404-4" )
          , UrlType.Bibtex ( path := bibtexPath "mcninch14:MR3181732.bib" )
          ]
         , title :=
            "Levi factors of the special fiber of a parahoric group scheme and tame ramification"
        }

def descent_levi_factors : IO MS := do
    let abs ← getAbstract "mcninch13:MR3009659.abstract"

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
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath "on-the-descent-of-levi-factors.pdf")
           , UrlType.MR ( mrNumber := "MR3009659" )
           , UrlType.DOI ( doiNumber := "10.1007/s00013-012-0467-y" )
           , UrlType.Bibtex ( path := bibtexPath "mcninch13:MR3009659.bib" ) 
           ]
         , title := "On the descent of Levi factors"
         }

def good_filtration_subgroups :  IO MS := do
    let abs ← getAbstract "hague13:MR3057320.abstract"

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
         , urls:=
           [ UrlType.Local
               ( path:= msPDFPath "some-good-filtration-subgroups-of-simple-algebraic-groups---2012-05.pdf" )
           , UrlType.MR ( mrNumber:= "MR3057320" )
           , UrlType.Arxiv ( arxivId:= "1205.1719" )
           , UrlType.DOI ( doiNumber:= "10.1016/j.jpaa.2013.04.005" )
           , UrlType.Bibtex ( path := bibtexPath "hague13:MR3057320.bib" )
           ]
         , title:= "Some good-filtration subgroups of simple algebraic groups"
         }

def levi_decompositions :  IO MS := do
    let abs ← getAbstract "mcninch10:MR2753264.abstract"
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
         , urls:=
           [ UrlType.Local
               ( path:= msPDFPath "levi-decompositions-of-a-linear-algebraic-group.pdf")
           , UrlType.MR ( mrNumber:= "MR2753264" )
           , UrlType.DOI ( doiNumber:= "10.1007/s00031-010-9111-8" )
           , UrlType.Arxiv ( arxivId:= "1007.2777" )
           , UrlType.Bibtex ( path := bibtexPath "mcninch10:MR2753264.bib" )
           , UrlType.Errata ( path := errataPath "errata-levi-decompositions.pdf" )
           ]
         , title:= "Levi decompositions of a linear algebraic group"
         }

def nilpotent_centralizers : IO MS := do
    let abs ← getAbstract "mcninch09:MR2497582.abstract"
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
         , urls:=
           [ UrlType.Local
               ( path:= msPDFPath "nilpotent-centralizers-and-springer-isomorphisms.pdf" )
           , UrlType.MR ( mrNumber:= "MR2497582" )
           , UrlType.DOI ( doiNumber:= "10.1016/j.jpaa.2008.12.007" )
           , UrlType.Arxiv ( arxivId:= "0805.2574" )
           , UrlType.Bibtex ( path := bibtexPath "mcninch09:MR2497582.bib" )
           ]
         , title:= "Nilpotent centralizers and Springer isomorphisms"
         }


def nilpotent_subalgebras : IO MS := do
    let abs ← getAbstract "levy09:MR2576893.abstract"
    pure { authors := [ PaulLevy, GeorgeMcNinch, DonnaTesterman ]
         , citation :=
             Citation.Journal
               ( journal :=
                   "Comptes Rendus Mathématique, Académie des Sciences, Paris")
               ( volume := some 347)
               ( year := 2009)
               ( number := some "9-10")
               ( pages := some "477--482")

         , id := "levy09:MR2576893"
         , abstract := some abs
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                  "levy-mcninch-and-testerman---nilpotent-subalgebras-of-semisimple-lie-algebras.pdf"
               )
           , UrlType.MR ( mrNumber := "mr2576893" )
           , UrlType.DOI ( doiNumber := "10.1016/j.crma.2009.03.015" )
           , UrlType.Bibtex ( path := bibtexPath "levy09:MR2576893.bib" )
           ]
         , title := "Nilpotent subalgebras of semisimple Lie algebras"
         }

def centralizer_nilpotent_section : IO MS := do
    let abs ← getAbstract "mcninch08:MR2423832.abstract" 
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               ( journal := "Nagoya Mathematical Journal")
               ( volume := some 190)
               ( year := 2008)
               ( number := none )
               ( pages := some "129--181")
         , id := "mcninch08:MR2423832"
         , abstract := some abs
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "The centralizer of a nilpotent section.pdf"
               )
           , UrlType.MR ( mrNumber := "MR2423832" )
           , UrlType.Arxiv ( arxivId := "math.RT/0605626" )
           , UrlType.Euclid ( euclidId := "euclid.nmj/1214229081" )
           , UrlType.Bibtex ( path := bibtexPath "mcninch08:MR2423832.bib" )
           , UrlType.Errata ( path := errataPath "errata--the-centralizer-of-a-nilpotent-section.pdf" )
           ]
         , title := "The centralizer of a nilpotent section"
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
         , ← nilpotent_subalgebras
         , ← centralizer_nilpotent_section
         ]

