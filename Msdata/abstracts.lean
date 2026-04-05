

structure Info  where
  id : String
  abstract : Option String
deriving Repr, BEq

def abstracts : List Info :=
 [
   {
     id:= "hhm26",
     abstract:= 
     
Option.some "We discuss local-global principles for the existence of Levi
factors (i.e., complements to the unipotent radical) for linear
algebraic groups over one-variable function fields. We give
examples of disconnected groups that fail the local-global
principle, and prove a strong local-global principle in the
presence of Levi descent."
   },
   
   {
     id := "mcninch24:cohomology-levi"
     abstract := 
     
Option.some "Let $k$ be a field, and let $G$ be a linear algebraic
group over $k$ for which the unipotent radical $U$ of $G$ is defined
and split over $k$.  Consider a finite, separable field extension
$ell$ of $k$ and suppose that the group $G_ell$ obtained by
base-change has a *Levi decomposition* (over $ell$). We continue here
our study of the question previously investigated in (McNinch 2013):
does $G$ have a *Levi decomposition* (over $k$)?

Using non-abelian cohomology we give some condition under which
this question has an affirmative answer.  On the other hand, we
provide an(other) example of a group $G$ as above which has no
Levi decomposition over $k$.  "
       
   },
   
   {
     id := "mcninch21:nilpotent-orbits-over-local-field"
     abstract := 
     
Option.some "Let $mathcal{K}$ be a *local field* -- i.e. the field of
fractions of a complete DVR $mathscr{A}$ whose residue field
$mathcal{k}$ has characteristic $p > 0$ -- and let $G$ be a connected,
absolutely simple algebraic $mathcal{K}$-group $G$ which splits over
an unramified extension of $mathcal{K}$. We study the rational
nilpotent orbits of $G$-- i.e. the orbits of $G(mathcal{K})$ in the
nilpotent elements of $operatorname{Lie}(G)(mathcal{K})$ -- under the
assumption $p>2h-2$ where $h$ is the Coxeter number of $G$.

A reductive group $M$ over $mathcal{K}$ is *unramified* if there is a
reductive model $mathcal{M}$ over $mathscr{A}$ for which $M =
mathcal{M}_mathcal{K}$. Our main result shows for any nilpotent
element $X_1 in operatorname{Lie}(G)$ that there is an unramified,
reductive $mathcal{K}$-subgroup $M$ which contains a maximal torus of
$G$ and for which $X_1 in operatorname{Lie}(M)$ is *geometrically
distinguished*.

The proof uses a variation on a result of DeBacker relating the
nilpotent orbits of $G$ with the nilpotent orbits of the reductive
quotient of the special fiber for the various parahoric group schemes
associated with $G$."
     

   }
   

]


#eval abstracts
