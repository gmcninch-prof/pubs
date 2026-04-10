
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
  | PhDThesis : (year : Nat) 
              → (institution : String) 
              → (advisor : String)
              → Citation
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

structure Author where
  institution : String
  name : String
  url : String
deriving Repr, BEq
    
structure MS where
  id : String
  authors : List Author
  citation : Citation
  abstract : Option String
  urls : List UrlType
  title : String
deriving Repr


