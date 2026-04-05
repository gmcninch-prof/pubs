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

#eval local_global
