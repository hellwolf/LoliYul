{-# LANGUAGE ExplicitNamespaces   #-}
{-# LANGUAGE UndecidableInstances #-}

{-|

Copyright   : (c) Miao ZhiCheng, 2023
License     : LGPL-3
Maintainer  : zhicheng.miao@gmail.com
Stability   : experimental
Portability : portable

= Description

Safe yul data coercion support for same representational data.

It is the code separated out in order to isolate the usage of UndecidableInstances extension.

-}

module LoliYul.Core.YulDSL.Coerce
  ( YulCoercible
  ) where

import           Control.Category.Constrained (type (⊗))

import           LoliYul.Core.ContractABI
import           LoliYul.Core.YulDSL.Obj

-- | Family of objects that have the same bytes representations.
class YulO2 a b => YulCoercible a b

instance YulCoercible UINT256 ADDR

instance YulO1 a     => YulCoercible (a⊗()) a
instance YulO2 a as  => YulCoercible (a :> as) (a⊗as)
instance YulO3 a b c => YulCoercible (a⊗(b⊗c)) ((a⊗b)⊗c)

instance {-# OVERLAPPABLE #-} YulCoercible b a => YulCoercible a b