import Msdata
import Msdata.Report
import Msdata.Data


def cvd : IO CVData := do
  let timestamp ← Std.Time.PlainDateTime.now
  let mss ← mss
  pure { mss := mss
         cvtarget := "results/cv-manuscripts.md"
         timestamp := timestamp }
  

def webd : IO WebData := do
  let mss ← mss
  pure { mss := mss
         file := "results/web-summaries.md"
       }


def main : IO Unit :=  do
  writeCV (← cvd)
  writeWebSummary (← webd)
  IO.println "ran!"

  
