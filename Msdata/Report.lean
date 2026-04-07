
import Msdata.Types
import Msdata.Data

import Markdown

def authorStr (ms : MS) : String :=
   String.intercalate ", " (Author.name <$> MS.authors ms)

def authorEntry (au : Author) : List Markdown.TextItem :=
    let name := Markdown.TextItem.link
        (text := s!"{au.name}")
        (url := au.authorUrl)
    let sp := Markdown.TextItem.text " "
    let inst := Markdown.TextItem.text s!"({au.institution})"
    [ name , sp, inst ]
  
def andList (ll : List (List Markdown.TextItem)) : List Markdown.TextItem :=
  match ll with
  | [] => [  ]
  | [a] => a 
  | [a,b] => a ++ Markdown.TextItem.text " and " :: b
  | a :: al => a ++ Markdown.TextItem.text ", " :: andList al

def authorList (ms : MS) : List Markdown.TextItem :=
  let au : List Author := 
     List.filter (fun a => not (a.name = "George McNinch")) ms.authors
  match au with
  | [] => []
  | a => Markdown.TextItem.text "  \n  With "
     :: (andList $ authorEntry <$> a)

def citationStr (ms : MS) : String :=
  match ms.citation with
  | Citation.Journal year journal number volume pages => 
      String.join
        [ journal
        , Option.elim volume "" fun v => s!" {reprStr v}"
        , s!" ({reprStr year})"
        , Option.elim number "" fun n => s!", no. {n}"
        , Option.elim pages  "" fun p => s!", pp. {p}"
        , "."
        ]
  | Citation.Accepted journal year =>
      s!"{journal} ({reprStr year})."
  | Citation.Proceedings year booktitle series volume pages =>
      String.join
        [ booktitle
        , Option.elim series "" fun s => s!", {s}"
        , Option.elim volume "" fun n => s!", no. {n}"
        , s!" ({reprStr year})"
        , Option.elim pages  "" fun p => s!", pp. {p}"
        , "."        ]        
  | Citation.PrePrint year => 
    s!"Preprint ({reprStr year})."
  | Citation.Submitted year => 
    s!"Submitted ({reprStr year})."  
  | Citation.Unpublished year => 
    s!"Unpublished ({reprStr year})."  
        

def year (ms : MS) : Nat :=
  match ms.citation with
  | Citation.Journal year _ _ _ _ => year
  | Citation.Accepted _ year => year
  | Citation.Proceedings year _ _ _ _ => year
  | Citation.PrePrint year => year
  | Citation.Submitted year => year
  | Citation.Unpublished year => year

def urlEntry (url : UrlType) : Markdown.TextItem :=
  match url with
  | UrlType.DOI doiNumber => 
    Markdown.TextItem.link 
      (text := "DOI")
      (url := "http://dx.doi.org/" ++ doiNumber)
  | UrlType.Other label url => 
    Markdown.TextItem.link
      (text := label)
      (url := url)
  | UrlType.MR mrNumber => 
    Markdown.TextItem.link
      (text := "MR")
      (url := "http://www.ams.org/mathscinet-getitem?mr=" ++ mrNumber)
  | UrlType.Arxiv arxivId => 
    Markdown.TextItem.link
      (text := "arXiv")
      (url := "http://arxiv.org/abs/" ++ arxivId)
  | UrlType.Euclid euclidId => 
    Markdown.TextItem.link
      (text := "Euclid")
      (url := "http://projecteuclid.org/euclid.nymj/" ++ euclidId)
  | UrlType.Local path => 
      Markdown.TextItem.link
        (text := "PDF")
        (url := path )
  | UrlType.Bibtex path =>
      Markdown.TextItem.link
        (text := "Bibtex")
        (url := path )
  | UrlType.Errata path =>
      Markdown.TextItem.link  
        (text := "Errata")
        (url := path)
  

def msUrls (ms : MS) : List Markdown.TextItem :=
  let urllist := urlEntry <$> ms.urls
  Markdown.TextItem.text "  \n  URLs: " :: List.intersperse (sep := Markdown.TextItem.text ", ") urllist

def cleanup (s:String) :  String :=
  String.toLower $ String.replace (s := strip s) (pattern := " ") (replacement:= "-")
  where
    strip t := 
      List.foldr 
        (fun c acc => String.replace ( s := acc) (pattern := c) (replacement := ""))
        t 
        ["(", ")", "/", "\\"]



def msLinkWeb (ms: MS) : String :=
  s!"#{cleanup ms.title}"  

def msLinkCV (ms: MS) : Markdown.TextItem :=
  let url := String.intercalate "/"
    [ "https://gmcninch.math.tufts.edu"
    , "pages"
    , s!"manuscripts.html#{cleanup ms.title}"  
    ]
  Markdown.TextItem.link 
   (text := ms.title)
   (url := url)

def webTitle (ms : MS) : Markdown.TextItem :=
  Markdown.TextItem.link
    (text := s!"{ms.title} ({reprStr $ year ms})") 
    (url := s!"#{ms.title}")
       
def cvBiblioEntry (ms : MS) : Markdown.MarkdownItem :=
  Markdown.MarkdownItem.p $
     [ msLinkCV ms 
     , Markdown.TextItem.text ", "
     , Markdown.TextItem.text $ citationStr ms
     ]
     ++ authorList ms
     ++ msUrls ms

def cvBiblio (mss : List MS) : Markdown.MarkdownTag :=
  { element := Markdown.MarkdownItem.h1 "Bibliography"
  , children := [ Markdown.MarkdownItem.ol $ Functor.map cvBiblioEntry mss ]
  }

def write : IO Unit := do
  let stdout <- IO.getStdout
  let mss <- mss
  let s := Markdown.renderMarkdownTag (cvBiblio mss)
  stdout.putStrLn s


#eval write
