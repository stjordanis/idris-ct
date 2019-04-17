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

> module Preorder.MonotoneMap
>
> %access public export
> %default total
>
> record MonotoneMap (t1 : Type) (po1 : t1 -> t1 -> Type) (t2 : Type) (po2 : t2 -> t2 -> Type) where
>   constructor MkMonotoneMap
>   func : t1 -> t2
>   funcRespOrd : (a, b : t1) -> po1 a b -> po2 (func a) (func b)