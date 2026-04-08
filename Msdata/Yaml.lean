
def Yaml := List (String × String)

def emitYaml (yaml : Yaml) : String := 
  let res := List.foldl 
    (fun accum (key,value) => accum ++ s!"{key}: {value}\n" ) 
    "" 
    yaml
  "---\n" ++ res ++ "---\n"

