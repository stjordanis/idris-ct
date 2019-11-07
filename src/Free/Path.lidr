\iffalse
SPDX-License-Identifier: AGPL-3.0-only

This file is part of `idris-ct` Category Theory in Idris library.

Copyright (C) 2019 Stichting Statebox <https://statebox.nl>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
\fi

> module Free.Path
>
> import Data.Vect
> import Free.Graph
>
> %access public export
> %default total
>
> data Path : (g : Graph) -> vertices g -> vertices g -> Type where
>   Nil  : Path g i i
>   (::) : edges g i j -> Path g j k -> Path g i k
>
> edgeToPath : {g : Graph} -> edges g i j -> Path g i j
> edgeToPath a = [a]
>
> joinPath : Path g i j -> Path g j k -> Path g i k
> joinPath [] y = y
> joinPath (x :: xs) y = x :: joinPath xs y
>
> joinPathNil : (p : Path g i j) -> joinPath p [] = p
> joinPathNil Nil       = Refl
> joinPathNil (x :: xs) = cong $ joinPathNil xs
>
> joinPathAssoc :
>      (p : Path g i j)
>   -> (q : Path g j k)
>   -> (r : Path g k l)
>   -> joinPath p (joinPath q r) = joinPath (joinPath p q) r
> joinPathAssoc Nil q r = Refl
> joinPathAssoc (x :: xs) q r = cong $ joinPathAssoc xs q r
>
> data EdgeListPath : (edges : Vect n (vertices, vertices)) -> vertices -> vertices -> Type where
>   Empty : EdgeListPath edges i i
>   Cons  : Elem (i, j) edges -> EdgeListPath edges j k -> EdgeListPath edges i k
>
>
> filterElemWhichIsHere : Eq t => (x : t) -> (l : Vect _ t) -> (k : Nat ** DPair.fst $ filter ((==) x) (x :: l) = S k)
> filterElemWhichIsHere x [] = (0 ** ?asdf)
> filterElemWhichIsHere x xs = ?qwer
>
> -- countOccurence : Eq vertices => {v1, v2 : vertices} -> Elem (v1, v2) edges -> Fin $ fst $ filter ((==) (v1, v2)) edges
> -- countOccurence           {edges = (v1 , v2 ) :: l} Here      = rewrite DPair.snd $ filterElemWhichIsHere l (v1, v2) in 0
> -- countOccurence {v1} {v2} {edges = (v1', v2') :: l} (There a) = let rec = countOccurence a in if (v1', v2') == (v1,v2) then weaken rec else ?qwer
>
> -- edgeListPath : Eq vertices
> --             => {edges : Vect n (vertices, vertices)}
> --             -> {i, j : vertices}
> --             -> EdgeListPath edges i j
> --             -> Path (edgeList edges) i j
> -- edgeListPath Empty           = Nil
> -- edgeListPath (Cons elem elp) = (countOccurence {edges} elem) :: (edgeListPath elp)
