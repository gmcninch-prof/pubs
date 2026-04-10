import Msdata
import Msdata.Report
import Msdata.Data

open Report

def cv : IO MSReport := do
  pure { msList := ← Data.all_manuscripts
         filename := "cv-manuscripts.md"
         targetDirs := [ "results"
                       , "/home/george/Prof-VC/cv-and-ms" ]
         proc := cvBiblio "Manuscripts" 
         yaml := none
       }
  

def web : IO MSReport := do
  pure { msList := ← Data.all_manuscripts
         filename := "manuscripts.md"
         targetDirs := [ "results"
                       , "/home/george/Web-hakyll/prof/assets/" ]         
         proc := fun mss => 
           webBiblio "Publication List" mss
           ++ [ { element := .h1 "Manuscript Details"  }
              ]
           ++ webDetails <$> mss
         yaml := some [ ( "author" , "George McNinch" )
                      , ( "title"  , "Manuscripts"    ) ]
       }


def main : IO Unit :=  do
  writeReport (← cv)
  writeReport (← web)
  IO.println "Finished!"

  
