import Msdata
import Msdata.Report
import Msdata.Data


def cv : IO MSReport := do
  let timestamp ← Std.Time.PlainDateTime.now
  pure { msList := ← mss
         filename := "results/cv-manuscripts.md"
         timestamp := some timestamp 
         proc := cvBiblio "Manuscripts" 
         yaml := none
       }
  

def web : IO MSReport := do
  pure { msList := ← mss
         filename := "results/manuscripts.md"
         timestamp := none
         proc := fun mss => 
           webBiblio "Publication List" mss
           ++ [ { element := .h1 "Manuscript Details"  }
              ]
           ++ webDetails <$> mss
         yaml := some [ ("author", "George McNinch")
                      , ("title", "Manuscripts") ]
       }


def main : IO Unit :=  do
  writeReport (← cv)
  writeReport (← web)
  IO.println "Finished!"

  
