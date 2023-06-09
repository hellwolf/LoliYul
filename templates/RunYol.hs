{-# LANGUAGE NoImplicitPrelude #-}

import           ClassicPrelude
import qualified Data.Text                as T

import qualified LoliYul.CodeGen.PlantUML
import LoliYul.Core (YulDSL)

import __YOL_MOD_NAME__

type Compiler = forall a b.  String -> YulDSL a b -> String

default (String)

compilers :: [Compiler]
compilers = [ \name cat -> "# __YOL_MOD_NAME__." <> name <> "\n\n" ++
                           show cat <> "\n\n" ++
                           "# " <> replicate 98 '-' <> "\n"
            , \name cat -> T.unpack (LoliYul.CodeGen.PlantUML.compile name cat) ++
                           "' " <> replicate 98 '-' <> "\n"
            ]

main :: IO ()
main = do
  __COMPILE_SYMBOLS__
  return ()
