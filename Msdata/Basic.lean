import Init.System.IO

inductive Citation where
  | Accepted : (journal : String) 
             → (year : Nat) 
             → Citation
  | Journal : (year : Nat)
            → (journal : String)
            → (number : Option String)
            → (volume : Option Nat)
            → (pages : Option String)
            → Citation
  | Proceedings : (year : Nat)
                → (booktitle : String)
                → (series : Option String)
                → (volume : Option Nat)
                → (pages : Option String)
                → Citation 
  | PrePrint : (year : Nat) → Citation
  | Submitted : (year : Nat) → Citation
  | Unpublished : (year : Nat) → Citation 
deriving Repr, BEq

inductive UrlType where
  | DOI : (doiNumber : String) → UrlType
  | MR : (mrNumber : String) → UrlType
  | Arxiv : (arxivId : String) → UrlType
  | Euclid : (euclidId : String) → UrlType
  | Local : (path : List String) → UrlType
  | Other : (label: String) → (url: String) → UrlType
deriving Repr, BEq

structure Author where
  institution : String
  name : String
  authorUrl : String
deriving Repr, BEq
    
structure MS where
  id : String
  authors : List Author
  citation : Citation
  abstract : Option String
  bibtex : Option String
  errata : Option String
  urls : List UrlType
  title : String
deriving Repr

--------------------------------------------------------------------------------

def mathManuscripts : String := 
  "/home/george/Prof-VC/Math-manuscripts"

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
   let abs <- IO.FS.readFile "my-paper-data/hhm26.abstract"
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
   let abs <- IO.FS.readFile  "my-paper-data/mcninch24:cohomology-levi.abstract"
   
   pure { authors := [ GeorgeMcNinch ]
        , citation := Citation.Accepted
             (year := 2024)
             (journal :=
                 "Pacific J. Math (Special issue in memory of Gary Seitz)")
        , id := "mcninch24:cohomology-levi"
        , abstract := abs
        , bibtex := Option.none 
        , errata := Option.none
        , urls :=
              [ UrlType.Local
                  ( path :=
                    [ mathManuscripts, "cohomology-levi", "cohomology-levi.pdf" ]
                  )
              ]
        , title :=
            "Levi decompositions of linear algebraic groups and non-abelian cohomology"
        }

def nilpotent_orbits_over_local_field : IO MS := do
   let abs <- IO.FS.readFile "my-paper-data/mcninch21:nilpotent-orbits-over-local-field.abstract"
   let bib <- IO.FS.readFile "my-paper-data/mcninch21:nilpotent-orbits-over-local-field.bib"
      
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
              ( path :=
                [ mathManuscripts
                , "2021-a--Nilpotent-elements-and-reductive-subgroups-over-a-local-field"
                , "Nilpotent-elements-and-reductive-subgroups-over-a-local-field.pdf"
                ]
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
        , title :=
            "Nilpotent elements and reductive subgroups over a local field"
        }


def reductive_subgroup_schemes : IO MS :=  do
    let abs <- IO.FS.readFile "my-paper-data/mcninch20:reductive-subgroup-schemes.abstract"
    let bib <- IO.FS.readFile "my-paper-data/mcninch20:reductive-subgroup-schemes.bib"

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
               ( path :=
                 [ mathManuscripts
                 , "2020-a--Reductive-subgroups-of-a-parahoric-group-scheme"
                 , "Reductive subgroups of a parahoric group scheme.pdf"
                 ]
               )
           , UrlType.MR ( mrNumber := "MR4070108" )
           , UrlType.DOI ( doiNumber := "10.1007/s00031-018-9508-3" )
           , UrlType.Other (label := "Journal") (url := "https://rdcu.be/bb6vn" )
           ]
         , title := "Reductive subgroup schemes of a parahoric group scheme"
         }

def central_subalgebras : IO MS := do
    let abs <- IO.FS.readFile "my-paper-data/mcninch16:MR3477055.abstract"
    let bib <- IO.FS.readFile "my-paper-data/mcninch16:MR3477055.bib"
    
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
               ( path :=
                 [ mathManuscripts
                 , "2016-a--Central-subalgebras-of-the-centralizer-of-a-nilpotent-element"
                 , "McNinch and Testerman - Central subalgebras - Proc AMS final.pdf"
                 ]
               )
           , UrlType.MR ( mrNumber := "MR3477055" )
           , UrlType.DOI ( doiNumber := "10.1090/proc/12942" )
           ]
         , title :=
             "Central subalgebras of the centralizer of a nilpotent element"
         }


def papers : IO (List MS) := do
    pure [ <- local_global
         , <- cohomology_levi
         , <- nilpotent_orbits_over_local_field
         , <- reductive_subgroup_schemes
         , <- central_subalgebras
         ]


#eval papers
  
