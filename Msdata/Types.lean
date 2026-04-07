
inductive Citation where
  | Accepted : (journal : String) 
             → (year : Nat) 
             → Citation
  | Journal : (year : Nat)
            → (journal : String)
            → (number : Option String)
            → (volume : Option Nat)
            → (pages : Option String)
            → Citation
  | Proceedings : (year : Nat)
                → (booktitle : String)
                → (series : Option String)
                → (volume : Option Nat)
                → (pages : Option String)
                → (publisher : Option String)
                → Citation 
  | PrePrint : (year : Nat) → Citation
  | Submitted : (year : Nat) → Citation
  | Unpublished : (year : Nat) → Citation 
deriving Repr, BEq

inductive UrlType where
  | DOI : (doiNumber : String) → UrlType
  | MR : (mrNumber : String) → UrlType
  | Arxiv : (arxivId : String) → UrlType
  | Euclid : (euclidId : String) → UrlType
  | Local : (path : String) → UrlType
  | Other : (label: String) → (url: String) → UrlType
  | Errata : (path : String) -> UrlType
  | Bibtex : (path : String) -> UrlType
deriving Repr, BEq

structure Author where
  institution : String
  name : String
  authorUrl : String
deriving Repr, BEq
    
structure MS where
  id : String
  authors : List Author
  citation : Citation
  abstract : Option String
  urls : List UrlType
  title : String
deriving Repr


