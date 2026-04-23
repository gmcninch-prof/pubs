import Pubs

open Report

def excludeAuthors : List Author := [ Data.GeorgeMcNinch ]

def cv : IO MSReport := do
  pure { msList := ← Data.all_manuscripts
         filename := "cv-manuscripts.md"
         targetDirs := [ "results"
                       , "/home/george/Prof-VC/cv-and-ms" ]
         proc := cvBiblio excludeAuthors "Manuscripts" 
         yaml := none
       }
       
  
def web : IO MSReport := do
  pure { msList := ← Data.all_manuscripts
         filename := "manuscripts.md"
         targetDirs := [ "results"
                       , "/home/george/Web-hakyll/prof/assets/" ]         
         proc := fun mss => 
           webBiblio excludeAuthors "Publication List" mss
           ++ [ { element := .h1 "Manuscript Details"  }
              ]
           ++ webDetails excludeAuthors <$> mss
         yaml := some [ ( "author" , "George McNinch" )
                      , ( "title"  , "Manuscripts"    ) ]
       }

def main : IO Unit :=  do
  writeReport (← cv)
  writeReport (← web)
  IO.println "Finished!"

  
