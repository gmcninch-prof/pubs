import Msdata
import Msdata.Report
import Msdata.Data


def cv : IO MSReport := do
  let timestamp ← Std.Time.PlainDateTime.now
  pure { msList := ← mss
         filename := "results/cv-manuscripts.md"
         timestamp := some timestamp 
         proc := cvBiblio "Manuscripts" 
       }
  

def web : IO MSReport := do
  pure { msList := ← mss
         filename := "results/web-summaries.md"
         timestamp := none
         proc := fun mss => webSummary <$> mss
       }


def main : IO Unit :=  do
  writeReport (← cv)
  writeReport (← web)
  IO.println "Finished!"

  
