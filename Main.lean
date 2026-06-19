import Pubs
import MLML.Pipeline

open Report

def loadData (filename : String) : IO (Except String (List MS)) :=  do
  let text ← IO.FS.readFile filename
  pure <| parseAndDecode text


def cv (mslist : List MS) : MSReport := 
  { msList := mslist
    filename := "cv-manuscripts.md"
    proc := cvBiblio (excludeAuthors := ["McNinch"]) "Manuscripts" 
    yaml := none
  }
       
  
def web (mslist : List MS) : MSReport := 
  { msList := mslist
    filename := "manuscripts.md"
    proc := fun mss => 
      webBiblio (excludeAuthors := ["McNinch"]) "Publication List" mss
      ++ [ { element := .h1 "Manuscript Details"  }
         ]
      ++ webDetails (excludeAuthors := ["McNinch"]) <$> mss
    yaml := some [ ( "author" , "George McNinch" )
                 , ( "title"  , "Manuscripts"    ) ]
  }

def main (args : List String) : IO Unit :=  do
  match args with 
  | [ pubfile, cvOutputDir, webOutputDir ] => do
    match (← loadData pubfile) with
    | .ok mslist => do
      writeReport (outputDir := cvOutputDir) <| cv mslist 
      writeReport (outputDir := webOutputDir) <| web mslist 
    | .error e => IO.println e
  | _ => do
    IO.println "usage: pubs <pubfile.mlml> <cvOutputDir> <webOutputDir>"

