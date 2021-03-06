{-# LANGUAGE NoImplicitPrelude
           , OverloadedStrings
           , PackageImports
           , UnicodeSyntax
  #-}

{-|
[@ISO639-1@]        mg

[@ISO639-2@]        mlg

[@ISO639-3@]        mlg

[@Native name@]     -

[@English name@]    Malagasy
-}

module Text.Numeral.Language.MG
    ( cardinal
    , struct
    ) where


-------------------------------------------------------------------------------
-- Imports
-------------------------------------------------------------------------------

import "base" Data.Function ( ($), const, fix )
import "base" Data.List     ( map )
import "base" Data.Maybe    ( Maybe(Just) )
import "base" Data.Monoid   ( Monoid )
import "base" Data.Ord      ( (<) )
import "base" Data.String   ( IsString )
import "base" Prelude       ( Integral, (-) )
import "base-unicode-symbols" Data.Function.Unicode ( (∘) )
import qualified "containers" Data.Map as M ( fromList, lookup )
import           "numerals-base" Text.Numeral
import           "numerals-base" Text.Numeral.Misc ( dec )
import qualified "numerals-base" Text.Numeral.Exp.Classes as C


-------------------------------------------------------------------------------
-- MG
-------------------------------------------------------------------------------

{-
Sources:
  http://en.wikipedia.org/wiki/Malagasy_language
  http://www.sf.airnet.ne.jp/~ts/language/number/malagasy.html
-}

cardinal ∷ (Integral α, Monoid s, IsString s) ⇒ α → Maybe s
cardinal = cardinalRepr ∘ struct

struct ∷ (Integral α, C.Unknown β, C.Lit β, C.Add β, C.Mul β) ⇒ α → β
struct = checkPos
       $ fix
       $ findRule (0, lit)
                  [(n, step n 10 L L) | n ← map dec [1..6]]
                  (dec 7 - 1)

cardinalRepr ∷ (Monoid s, IsString s) ⇒ Exp → Maybe s
cardinalRepr = render defaultRepr
               { reprValue = \n → M.lookup n syms
               , reprAdd   = Just (⊞)
               , reprMul   = Just (⊡)
               }
    where
      (_ ⊞              Lit 10 ) _ = " ambin'ny "
      (_ ⊞ (Lit _ `Mul` Lit 10)) _ = " amby "
      (_ ⊞ _                   ) _ = " sy "

      (_ ⊡ Lit 10 ) _ = ""
      (_ ⊡ Lit 100) _ = ""
      (_ ⊡ _      ) _ = " "

      syms =
          M.fromList
          [ (0, const "haotra")
          , (1, \c → case c of
                       CtxAdd {} → "iraika"
                       _         → "iray"
            )
          , (2, mulForms "roa"    "roa"   "roan")
          , (3, mulForms "telo"   "telo"  "telon")
          , (4, mulForms "efatra" "efa"   "efa"  )
          , (5, mulForms "dimy"   "dimam" "diman")
          , (6, mulForms "enina"  "enim"  "enin" )
          , (7, mulForms "fito"   "fito"  "fiton")
          , (8, mulForms "valo"   "valo"  "valon")
          , (9, mulForms "sivy"   "sivi"  "sivin")
          , (10, \c → case c of
                        CtxMul _ (Lit n) _
                            | n < 9 → "polo"
                        _           → "folo"
            )
          , (100, \c → case c of
                         CtxMul {} → "jato"
                         _         → "zato"
            )
          , (1000, const "arivo")
          , (dec 4, const "alina")
          , (dec 5, const "hetsy")
          , (dec 6, const "tapitrisa")
          ]

      mulForms o t h = \c → case c of
                              CtxMul _ (Lit 10)  _ → t
                              CtxMul _ (Lit 100) _ → h
                              _                    → o
