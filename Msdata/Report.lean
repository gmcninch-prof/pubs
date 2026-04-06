
import Msdata.Types
import Msdata.Data


def summarize (dat : List MS) : String  :=
  String.intercalate "\n" (List.map MS.title dat)



def write : IO Unit := do
  let stdout <- IO.getStdout
  let s <- Functor.map summarize papers
  stdout.putStrLn s


#eval write
