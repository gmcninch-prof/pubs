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
              ( label := "ART" )
              ( url := "https://link.springer.com/article/10.1007%2Fs10468-020-10000-2" )
          , UrlType.Other 
              ( label := "Springer" ) 
              ( url := "https://rdcu.be/b8AHO" )              
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
           , UrlType.Other (label := "TG") (url := "https://rdcu.be/bb6vn" )
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
                   "the-centralizer-of-a-nilpotent-section.pdf"
               )
           , UrlType.MR ( mrNumber := "MR2423832" )
           , UrlType.Arxiv ( arxivId := "math.RT/0605626" )
           , UrlType.Euclid ( euclidId := "euclid.nmj/1214229081" )
           , UrlType.Bibtex ( path := bibtexPath "mcninch08:MR2423832.bib" )
           , UrlType.Errata ( path := errataPath "errata--the-centralizer-of-a-nilpotent-section.pdf" )
           ]
         , title := "The centralizer of a nilpotent section"
         }



def cr_lie_subalgebras : IO MS := do
    let abs ← getAbstract "mcninch07:MR2308032.abstract" 
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               ( journal := "Transformation Groups" )
               ( volume := some 12 )
               ( year := 2007 )
               ( number := some "1" )
               ( pages := some "127--135" )
         , id := "mcninch07:MR2308032"
         , abstract := some abs
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "completely-reducible-lie-subalgebras-revised-dec.pdf"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch07:MR2308032.bib" )               
           , UrlType.MR ( mrNumber := "MR2308032" )
           , UrlType.DOI ( doiNumber := "10.1007/s00031-005-1130-5" )
           , UrlType.Arxiv ( arxivId := "math.RT/0509590" )
           ]
         , title := "Completely reducible Lie subalgebras"
         }

def cr_sl2_homs : IO MS := do
    let abs ← getAbstract "mcninch07:MR2309195.abstract" 
    pure { authors := [ GeorgeMcNinch, DonnaTesterman ]
         , citation :=
             Citation.Journal
               ( journal := "Transactions of the American Mathematical Society" )
               ( volume := some 359 )
               ( year := 2007 )
               ( number := some "9" )
               ( pages := some "4489--4510 (electronic)" )
         , id := "mcninch07:MR2309195"
         , abstract := some abs
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "completely-reducible-sl(2)-homomorphisms.pdf"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch07:MR2309195.bib" )               
           , UrlType.DOI ( doiNumber := "10.1090/S0002-9947-07-04289-4" )
           , UrlType.Arxiv ( arxivId := "math.RT/0510377" )
           , UrlType.MR ( mrNumber := "MR2309195" )
           ]
         , title := "Completely reducible SL(2) homomorphisms"
         }

def centralizer_sum_commuting : IO MS := do
    let abs ← getAbstract "mcninch06:MR2220085.abstract" 
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               ( journal := "Journal of Pure and Applied Algebra" )
               ( volume := some 206 )
               ( year := 2006 )
               ( number := some "1-2" )
               ( pages := some "123--140" )
               
         , id := "mcninch06:MR2220085"
         , abstract := some abs
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "on-the-centralizer-of-the-sum-of-commuting-nilpotent-elements.pdf"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch06:MR2220085.bib" )               
           , UrlType.DOI ( doiNumber := "10.1016/j.jpaa.2005.04.016" )
           , UrlType.Arxiv ( arxivId := "math.RT/0412283" )
           , UrlType.MR ( mrNumber := "MR2220085" )
           ]
         , title :=
             "On the centralizer of the sum of commuting nilpotent elements"
         }

def optimal_sl2 : IO MS := do
    let abs ← getAbstract "mcninch05:MR2142248.abstract" 
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               ( journal := "Commentarii Mathematici Helvetici" )
               ( volume := some 80 )
               ( year := 2005 )
               ( number := some "2" )
               ( pages := some "391--426" )
               
         , id := "mcninch05:MR2142248"
         , abstract := some abs
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "optimal-sl(2)-homomorphisms.pdf"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch05:MR2142248.bib" )               
           , UrlType.Arxiv ( arxivId := "math.RT/0309385" )
           , UrlType.DOI ( doiNumber := "10.4171/CMH/19" )
           , UrlType.MR ( mrNumber := "MR2142248" )
           ]
         , title := "Optimal SL(2) homomorphisms"
         }

def nilpotent_over_ground_field : IO MS := do
    let abs ← getAbstract "mcninch04:MR2052869.abstract" 
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               ( journal := "Mathematische Annalen" )
               ( volume := some 329 )
               ( year := 2004 )
               ( number := some "1" )
               ( pages := some "49--85" )
               
         , id := "mcninch04:MR2052869"
         , abstract := some abs
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "nilpotent-orbits-over-ground-fields-of-good-characteristic.pdf"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch04:MR2052869.bib" )               
           , UrlType.DOI ( doiNumber := "10.1007/s00208-004-0510-9" )
           , UrlType.Arxiv ( arxivId := "math.RT/0209151" )
           , UrlType.MR ( mrNumber := "MR2052869" )
           ]
         , title := "Nilpotent orbits over ground fields of good characteristic"
         }

def sub_principal : IO MS := do
    let abs ← getAbstract "mcninch03:MR1992546.abstract" 
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               ( journal := "Mathematische Zeitschrift" )
               ( volume := some 244 )
               ( year := 2003 )
               ( number := some "2" )
               ( pages := some "433--455" )
               
         , id := "mcninch03:MR1992546"
         , abstract := some abs
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "sub-principal-homomorphisms-in-positive-characteristic.pdf"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch03:MR1992546.bib" )               
           , UrlType.Arxiv ( arxivId := "math/0108140" )
           , UrlType.DOI ( doiNumber := "10.1007/s00209-003-0508-0" )
           , UrlType.MR ( mrNumber := "MR1992546" )
           ]
         , title := "Sub-principal homomorphisms in positive characteristic"
         }

def sl2_Witt : IO MS := do
    let abs ← getAbstract "mcninch03:MR1987019.abstract" 
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               ( journal := "Journal of Algebra" )
               ( volume := some 265 )
               ( year := 2003 )
               ( number := some "2" )
               ( pages := some "606--618" )
               
         , id := "mcninch03:MR1987019"
         , abstract := some abs
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "faithful-representations-of-sl2-over-truncated-witt-vectors.pdf"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch03:MR1987019.bib" )               
           , UrlType.MR ( mrNumber := "MR1987019" )
           , UrlType.Arxiv ( arxivId := "math.RT/0109107" )
           , UrlType.DOI ( doiNumber := "10.1016/S0021-8693(03)00269-2" )
           ]
         , title :=
             "Faithful representations of SL(2) over truncated Witt vectors"
         }

def adjoint_jordan_blocks : IO MS := do
    let abs ← getAbstract "mcninch03:arXiv.0207001.abstract" 
    pure { authors := [ GeorgeMcNinch ]
         , citation := Citation.Unpublished ( year := 2003 )
         , id := "mcninch03:arXiv.0207001"
         , abstract := some abs
         , urls :=
           [ UrlType.Local
            ( path := msPDFPath
              "2003-08---adjoint-jordan-blocks.pdf"
            )
           , UrlType.Bibtex ( path := bibtexPath "mcninch03:arXiv.0207001.bib" )            
           , UrlType.Arxiv ( arxivId := "math/0207001" )
           ]
         , title := "Adjoint Jordan Blocks"
         }

def component_group_unipotent_centralizer : IO MS := do
    let abs ← getAbstract "mcninch03:MR1976698.abstract" 
    pure { authors := [ GeorgeMcNinch, EricSommers ]
         , citation :=
             Citation.Journal
               ( journal := "Journal of Algebra" )
               ( volume := some 260 )
               ( year := 2003 )
               ( number := some "1" )
               ( pages := some "323--337" )
               
         , id := "mcninch03:MR1976698"
         , abstract := some abs
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "component-groups-of-unipotent-centralizers-in-good-characteristic.pdf"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch03:MR1976698.bib" )               
           , UrlType.MR ( mrNumber := "MR1976698" )
           , UrlType.DOI ( doiNumber := "10.1016/S0021-8693(02)00661-0" )
           , UrlType.Arxiv ( arxivId := "math.RT/0204275" )
           ]
         , title :=
             "Component groups of unipotent centralizers in good characteristic"
         }

def second_cohomology : IO MS := do
    let abs ← getAbstract "mcninch02:MR1907901.abstract" 
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               ( journal := "Pacific Journal of Mathematics" )
               ( volume := some 204 )
               ( year := 2002 )
               ( number := some "2" )
               ( pages := some "459--472" )
               
         , id := "mcninch02:MR1907901"
         , abstract := some abs
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "the-second-cohomology-of-small-modules.pdf"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch02:MR1907901.bib" )               
           , UrlType.MR ( mrNumber := "MR1907901" )
           , UrlType.Arxiv ( arxivId := "math.RT/0006105" )
           , UrlType.DOI ( doiNumber := "10.2140/pjm.2002.204.459" )
           , UrlType.Errata ( path := errataPath "Errata---Second-cohomology.pdf" )
           ]
         , title :=
             "The second cohomology of small irreducible modules for simple algebraic groups"
         }

def abelian_unipotent_subgroups : IO MS := do
    let abs ← getAbstract "mcninch02:MR1874545.abstract" 
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               ( journal := "Journal of Pure and Applied Algebra" )
               ( volume := some 167 )
               ( year := 2002 )
               ( number := some "2-3" )
               ( pages := some "269--300" )
               
         , id := "mcninch02:MR1874545"
         , abstract := some abs
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "abelian-unipotent-subgroups-of-reductive-groups.pdf"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch02:MR1874545.bib" )                              
           , UrlType.DOI ( doiNumber := "10.1016/S0022-4049(01)00038-X" )
           , UrlType.Arxiv ( arxivId := "math.RT/0007056" )
           , UrlType.MR ( mrNumber := "MR1874545" )
           , UrlType.Errata ( path := errataPath 
               "abelian-unipotent-subgroups-of-reductive-groups---erratum.pdf")           
           ]
         , title := "Abelian unipotent subgroups of reductive groups"
         }

def howe_duality : IO MS := do
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               ( journal := "Mathematische Zeitschrift" )
               ( volume := some 235 )
               ( year := 2000 )
               ( number := some "4" )
               ( pages := some "651--685" )
               
         , id := "mcninch00:MR1801579"
         , abstract := none
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "filtrations-and-positive-characteristic-howe-duality.tex"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch00:MR1801579.bib" )               
           , UrlType.MR ( mrNumber := "MR1801579" )
           , UrlType.DOI ( doiNumber := "10.1007/s002090000157" )
           ]
         , title := "Filtrations and positive characteristic Howe duality"
         }

def semisimplicity_exterior_powers : IO MS := do
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               ( journal := "Journal of Algebra" )
               ( volume := some 225 )
               ( year := 2000 )
               ( number := some "2" )
               ( pages := some "646--666" )
               
         , id := "mcninch00:MR1741556"
         , abstract := none
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "semisimplicity-of-exterior-powers-of-semisimple-representations-of-groups.pdf"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch00:MR1741556.bib" )               
           , UrlType.MR ( mrNumber := "MR1741556" )
           , UrlType.DOI ( doiNumber := "10.1006/jabr.1999.8132" )
           , UrlType.Errata ( path := errataPath "errata---exterior-powers.pdf")           
           ]
         , title :=
             "Semisimplicity of exterior powers of semisimple representations of groups"
         }

def semisimple_finite_Lie : IO MS := do
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               ( journal := "Journal of the London Mathematical Society" )
               ( volume := some 60 )
               ( year := 1999 )
               ( number := some "3" )
               ( pages := some "771--792" )
               
         , id := "mcninch99:MR1753813"
         , abstract := none
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "semisimple-modules-for-finite-groups-of-lie-type.pdf"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch99:MR1753813.bib" )               
           , UrlType.MR ( mrNumber := "MR1753813" )
           , UrlType.DOI ( doiNumber := "10.1112/S0024610799007966" )
           ]
         , title := "Semisimple modules for finite groups of Lie type"
         }

def dimensional_criteria : IO MS := do
    let abs ← getAbstract "mcninch98:MR1476899.abstract" 
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Journal
               ( journal := "Proceedings of the London Mathematical Society" )
               ( volume := some 76 )
               ( year := 1998 )
               ( number := some "1" )
               ( pages := some "95--149" )
               
         , id := "mcninch98:MR1476899"
         , abstract := some abs
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "dimensional-criteria-for-semisimplicity-of-representations.pdf"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch98:MR1476899.bib" )               
           , UrlType.DOI ( doiNumber := "10.1112/S0024611598000045" )
           , UrlType.MR ( mrNumber := "MR1476899" )
           , UrlType.Errata ( path := errataPath "errata-for-dimensional-criteria.pdf")           
           ]
         , title := "Dimensional criteria for semisimplicity of representations"
         }

def semisimple_pos_char : IO MS := do
    pure { authors := [ GeorgeMcNinch ]
         , citation :=
             Citation.Proceedings
               ( booktitle := "Algebraic groups and their representations" )
               ( series := some "NATO Adv. Sci. Inst. Ser. C Math. Phys. Sci." )
               ( volume := some 517 )
               ( year := 1998 )
               ( pages := some "43--52" )
               ( publisher := some "Kluwer Acad. Publ., Dordrecht" )
         , id := "mcninch98:MR1670763"
         , abstract := none
         , urls :=
           [ UrlType.Local
               ( path := msPDFPath
                   "semisimplicity-in-positive-characteristic-(survey).pdf"
               )
           , UrlType.Bibtex ( path := bibtexPath "mcninch98:MR1670763.bib" )               
           , UrlType.MR ( mrNumber := "MR1670763" )
           ]
         , title := "Semisimplicity in positive characteristic"
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
         , ← cr_lie_subalgebras
         , ← cr_sl2_homs
         , ← centralizer_sum_commuting
         , ← optimal_sl2
         , ← nilpotent_over_ground_field
         , ← sub_principal
         , ← sl2_Witt
         , ← adjoint_jordan_blocks
         , ← component_group_unipotent_centralizer
         , ← second_cohomology
         , ← abelian_unipotent_subgroups
         , ← howe_duality
         , ← semisimplicity_exterior_powers
         , ← semisimple_finite_Lie
         , ← dimensional_criteria
         , ← semisimple_pos_char
         ]

