
import Msdata.Types
import Msdata.Yaml

import Std.Time 

import Markdown


open Markdown

namespace Report

def authorStr (ms : MS) : String :=
   String.intercalate ", " (Author.name <$> MS.authors ms)

def andList (ll : List (List Markdown.TextItem)) : List Markdown.TextItem :=
  match ll with
  | [] => [  ]
  | [a] => a ++ [ .text "." ] 
  | [a,b] => a ++ .text " and " :: andList [ b ]
  | a :: al => a ++ .text ", " :: andList al

def authorEntry (au : Author) : List Markdown.TextItem :=
    let name := .link
        (text := au.name)
        (url := au.url)
    let sp := .text " "
    let inst := .text s!"({au.institution})"
    [ name , sp, inst ]
  
def authorList (excludeAuthors : List Author) (ms : MS) : List Markdown.TextItem :=
  let au : List Author := 
     List.filter (fun a => not (List.elem a excludeAuthors)) ms.authors
  match au with
  | [] => []
  | a => .text "  \nWith "
     :: (andList $ authorEntry <$> a)

def citationStr (ms : MS) : String :=
  match ms.citation with
  | .Journal year journal number volume pages => 
      String.join
        [ journal
        , Option.elim volume "" fun v => s!" {reprStr v}"
        , s!" ({reprStr year})"
        , Option.elim number "" fun n => s!", no. {n}"
        , Option.elim pages  "" fun p => s!", pp. {p}"
        , "."
        ]
  | .Accepted journal year =>
      s!"{journal} ({reprStr year})."
  | .Proceedings year booktitle series volume pages _ =>
      String.join
        [ booktitle
        , Option.elim series "" fun s => s!", {s}"
        , Option.elim volume "" fun n => s!", no. {n}"
        , s!" ({reprStr year})"
        , Option.elim pages  "" fun p => s!", pp. {p}"
        , "."        ]        
  | .PrePrint year => 
    s!"Preprint ({reprStr year})."
  | .Submitted year => 
    s!"Submitted ({reprStr year})."  
  | .Unpublished year => 
    s!"Unpublished ({reprStr year})."  
  | .PhDThesis year institution advisor =>
    s!"Ph.D. Thesis, {institution} ({reprStr year}), advisor {advisor}."

def year (ms : MS) : Nat :=
  match ms.citation with
  | .Journal year _ _ _ _ => year
  | .Accepted _ year => year
  | .Proceedings year _ _ _ _ _ => year
  | .PrePrint year => year
  | .Submitted year => year
  | .Unpublished year => year
  | .PhDThesis year _ _ => year

def urlEntry (url : UrlType) : Markdown.TextItem :=
  match url with
  | .DOI doiNumber => 
    .link 
      (text := "[DOI]")
      (url := "http://dx.doi.org/" ++ doiNumber)
  | .Other label url => 
    .link
      (text := s!"[{label}]")
      (url := url)
  | .MR mrNumber => 
    .link
      (text := "[MathReview]")
      (url := "http://www.ams.org/mathscinet-getitem?mr=" ++ mrNumber)
  | .Arxiv arxivId => 
    .link
      (text := "[arXiv]")
      (url := "http://arxiv.org/abs/" ++ arxivId)
  | .Euclid euclidId => 
    .link
      (text := "[Euclid]")
      (url := "http://projecteuclid.org/" ++ euclidId)
  | .Local path => 
      .link
        (text := "[PDF]")
        (url := path )
  | .Bibtex path =>
      .link
        (text := "[BibTeX]")
        (url := path )
  | .Errata path =>
      .link  
        (text := "[**Errata**]")
        (url := path)
  

def msUrls (ms : MS) : List Markdown.TextItem :=
  let sortedUrls := ms.urls.mergeSort (fun a b => compare a b |>.isLT)
  let urllist := urlEntry <$> sortedUrls
  .text "  \n**Links**: " :: List.intersperse (sep := Markdown.TextItem.text ", ") urllist

def cleanup (s:String) :  String :=
  String.toLower $ .replace (s := strip s) (pattern := " ") (replacement:= "-")
  where
    strip t := 
      List.foldr 
        (fun c acc => .replace ( s := acc) (pattern := c) (replacement := ""))
        t 
        ["(", ")", "/", "\\"]


def msLinkCV (ms: MS) : Markdown.TextItem :=
  let url := .intercalate "/"
    [ "https://gmcninch.math.tufts.edu"
    , "pages"
    , s!"manuscripts.html#{cleanup ms.title}"  
    ]
  Markdown.TextItem.link 
   (text := ms.title)
   (url := url)

def msLinkWeb (ms: MS) : Markdown.TextItem :=
  let url := s!"#{cleanup ms.title}"  
  Markdown.TextItem.link 
    (text := ms.title)
    (url := url)


def webTitle (ms : MS) : Markdown.TextItem :=
  Markdown.TextItem.link
    (text := s!"{ms.title} ({reprStr $ year ms})") 
    (url := s!"#{ms.title}")
       
def biblioEntryCV  (excludeAuthors : List Author) (ms : MS) : Markdown.MarkdownItem :=
  .p $ [ msLinkCV ms 
       , .text ", "
       , .text $ citationStr ms
       ]
       ++ authorList excludeAuthors ms
       ++ msUrls ms

def biblioEntryWeb (excludeAuthors : List Author) (ms : MS) : Markdown.MarkdownItem :=
  .p $ [ msLinkWeb ms 
       , .text ", "
       , .text $ citationStr ms
       ]
       ++ authorList excludeAuthors ms


def cvBiblio (excludeAuthors : List Author) (title : String) (mss : List MS) : List Markdown.MarkdownTag :=
  [ { element := .h1 title 
      children := [ .ol $ biblioEntryCV excludeAuthors <$> mss ]
    }
  ]

def webBiblio (excludeAuthors : List Author) (title : String) (mss : List MS) : List Markdown.MarkdownTag :=
  [ { element := .h1 title 
      children := [ .ol $ biblioEntryWeb excludeAuthors <$> mss ]
    }
  ]

def webDetails (excludeAuthors : List Author) (ms : MS) : Markdown.MarkdownTag :=
  { element := .h2 $ ms.title ++ " {#" ++ cleanup ms.title ++ "}"
    children := [ .p  $
       [ .text "\n\n**Citation**: "
       , .text $ citationStr ms 
       ]
       ++ authorList excludeAuthors ms
       ++ msUrls ms         
       ++ Option.elim ms.abstract [] (fun abs =>
           [ .text "  \n\n**Abstract**: "
           , .text abs])
       ++ [ .text "\n\n------"
          ]
     ]        
    }

structure MSReport  where
  msList : List MS
  filename : System.FilePath
  targetDirs : List System.FilePath
  proc : List MS -> List MarkdownTag
  yaml : Option SimpleYaml.Yaml

instance : Markdown.Represent MSReport where
  toMarkdown r :=
    (r.proc r.msList)
         

def writeReport (msr : MSReport) : IO Unit := do
  let write (dir : System.FilePath) : IO Unit :=  do
    let target := System.FilePath.join dir msr.filename 
    IO.FS.writeFile 
      (fname := target) 
      (content := 
          Option.elim msr.yaml "" (fun y => SimpleYaml.emitYaml y)
          ++ renderMarkdown (Markdown.Represent.toMarkdown msr))
    IO.println s!"Wrote {target}."
  List.forM msr.targetDirs write


-- times stamp code

--  timestamp : Option Std.Time.PlainDateTime

    -- ++ Option.elim 
    --      r.timestamp
    --      [] 
    --      (fun ts => 
    --          [{ element := MarkdownItem.p 
    --              [ TextItem.text "Time-stamp: "
    --              , TextItem.text $ Std.Time.PlainDateTime.toLongDateFormatString ts ] 
    --          }])
