
import MLML.Codec

open Codec

inductive Citation where
  | Accepted : (journal : String) 
             → (year    : Nat) 
             → Citation
  | Journal : (year : Nat)
            → (journal : String)
            → (number  : Option String)
            → (volume  : Option Nat)
            → (pages   : Option String)
            → Citation
  | Proceedings : (year      : Nat)
                → (booktitle : String)
                → (series    : Option String)
                → (volume    : Option Nat)
                → (pages     : Option String)
                → (publisher : Option String)
                → Citation 
  | PrePrint    : (year : Nat) → Citation
  | Submitted   : (year : Nat) → Citation
  | Unpublished : (year : Nat) → Citation 
  | PhDThesis   : (year : Nat) 
                → (institution : String) 
                → (advisor     : String)
                → Citation
deriving Repr, BEq

instance : Decode Citation where
  decode 
    | .Record "Accepted" fs => do
      let journal ← Codec.decodeField "journal" fs
      let year    ← Codec.decodeField "year" fs
      pure <| .Accepted journal year 
    | .Record "Journal" fs => do
      let year    ← Codec.decodeField "year" fs 
      let journal ← Codec.decodeField "journal" fs
      let number  ← Codec.decodeFieldOpt "number" fs
      let volume  ← Codec.decodeFieldOpt "volume" fs
      let pages   ← Codec.decodeFieldOpt "pages" fs
      pure <| .Journal year journal number volume pages
    | .Record "Proceedings" fs => do
      let year      ← Codec.decodeField "year" fs
      let booktitle ← Codec.decodeField "booktitle" fs
      let series    ← Codec.decodeFieldOpt "series" fs
      let volume    ← Codec.decodeFieldOpt "volume" fs
      let pages     ← Codec.decodeFieldOpt "pages" fs
      let publisher ← Codec.decodeFieldOpt "publisher" fs      
      pure <| .Proceedings year booktitle series volume pages publisher
    | .Record "PrePrint" fs => do
      let year ← Codec.decodeField "year" fs
      pure <| .PrePrint year
    | .Record "Submitted" fs => do
      let year ← Codec.decodeField "year" fs
      pure <| .Submitted year      
    | .Record "Unpublished" fs => do
      let year ← Codec.decodeField "year" fs
      pure <| .Unpublished year            
    | .Record "PhDThesis" fs => do
      let institution ← Codec.decodeField "institution" fs
      let advisor     ← Codec.decodeField "advisor" fs      
      let year        ← Codec.decodeField "year" fs
      pure <| .PhDThesis year institution advisor
    |e => .error s!"Expected Citation; got {repr e}"
    
inductive UrlType where
  | DOI    : (doiNumber : String) → UrlType
  | MR     : (mrNumber : String)  → UrlType
  | Arxiv  : (arxivId : String)   → UrlType
  | Euclid : (euclidId : String)  → UrlType
  | Local  : (path : List String) → UrlType
  | Errata : (path : List String) → UrlType
  | Bibtex : (path : List String) → UrlType
  | Other  : (label: String)      → (url: String) → UrlType    
deriving Repr, BEq

def UrlType.rank : UrlType → Nat
  | .Local _     => 0    
  | .DOI _       => 1
  | .Euclid _    => 2  
  | .Arxiv _     => 3
  | .Other _ _   => 4
  | .MR _        => 5  
  | .Bibtex _    => 6  
  | .Errata _    => 7

instance : Ord UrlType where
  compare a b := compare a.rank b.rank

instance : Decode UrlType where
  decode 
    | .Record "DOI" fs => do
      let doiNumber ← Codec.decodeField "doiNumber" fs
      pure <| .DOI doiNumber
    | .Record "MR" fs => do
      let mrNumber  ← Codec.decodeField "mrNumber" fs
      pure <| .MR mrNumber 
    | .Record "Arxiv" fs => do
      let arxivId  ← Codec.decodeField "arxivId" fs
      pure <| .Arxiv arxivId
    | .Record "Euclid" fs => do
      let euclidId  ← Codec.decodeField "euclidId" fs
      pure <| .Euclid euclidId       
    | .Record "Local" fs => do
      let path  ← Codec.decodeField "path" fs
      pure <| .Local path
    | .Record "Errata" fs => do
      let path  ← Codec.decodeField "path" fs
      pure <| .Errata path
    | .Record "Bibtex" fs => do
      let path  ← Codec.decodeField "path" fs
      pure <| .Bibtex path      
    | .Record "Other" fs => do
      let label  ← Codec.decodeField "label" fs
      let url    ← Codec.decodeField "url" fs
      pure <| .Other label url
    | e => .error s!"Expected UrlTYpe; got {repr e}"

structure Author where
  institution : String
  name : String
  url : String
deriving Repr, BEq
    
instance : Decode Author where
  decode 
    | .Record "Author" fs => do
      let institution ← Codec.decodeField "institution" fs
      let name        ← Codec.decodeField "name" fs
      let url         ← Codec.decodeField "url" fs
      pure <| {institution, name, url}
    | e => .error s!"Expected Author; got {repr e}"
    
structure MS where
  id : String
  authors : List Author
  citation : Citation
  abstract : Option String
  urls : List UrlType
  title : String
deriving Repr

instance : Decode MS where
  decode
    | .Record "MS" fs => do
      let id       ← Codec.decodeField "id" fs
      let authors  ← Codec.decodeField "authors" fs
      let citation ← Codec.decodeField "citation" fs
      let abstract ← Codec.decodeFieldOpt "abstract" fs
      let urls     ← Codec.decodeField "urls" fs
      let title    ← Codec.decodeField "title" fs
      pure <| { id, authors, citation, abstract, urls, title }
    | e => .error s!"Expected Author; got {repr e}"    

