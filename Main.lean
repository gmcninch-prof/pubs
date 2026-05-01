import Pubs
import MLML.Pipeline

open Report

def loadData (filename : String) : IO (Except String (List MS)) :=  do
  let text ← IO.FS.readFile filename
  pure <| parseAndDecode text


def cv (mslist : List MS) : MSReport := 
  { msList := mslist
    filename := "cv-manuscripts.md"
    targetDirs := [ "results"
                  , "/home/george/Prof-VC/cv-and-ms" ]
    proc := cvBiblio (excludeAuthors := ["McNinch"]) "Manuscripts" 
    yaml := none
  }
       
  
def web (mslist : List MS) : MSReport := 
  { msList := mslist
    filename := "manuscripts.md"
    targetDirs := [ "results"
                  , "/home/george/Web-hakyll/prof/assets/" ]         
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
  | [ pubfile ] => do
    match (← loadData pubfile) with
    | .ok mslist => do
      writeReport <| cv mslist
      writeReport <| web mslist
      IO.println "Finished!"
    | .error e => IO.println e
  | _ => do
    IO.println "usage: pubs <pubfile.mll>"

  
#eval main ["data/publications.mlml"]
