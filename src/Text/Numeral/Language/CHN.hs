{-# LANGUAGE NoImplicitPrelude
           , OverloadedStrings
           , PackageImports
           , UnicodeSyntax
  #-}

{-|
[@ISO639-1@]        -

[@ISO639-2B@]       chn

[@ISO639-3@]        chn

[@Native name@]     -

[@English name@]    Chinook Jargon
-}

module Text.Numeral.Language.CHN
    ( cardinal
    , struct
    ) where


--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------

import "base" Data.Function ( ($), const, fix )
import "base" Data.Maybe    ( Maybe(Just) )
import "base" Data.Monoid   ( Monoid )
import "base" Data.String   ( IsString )
import "base" Prelude       ( Integral )
import "base-unicode-symbols" Data.Function.Unicode ( (∘) )
import qualified "containers" Data.Map as M ( fromList, lookup )
import "numerals-base" Text.Numeral
import qualified "numerals-base" Text.Numeral.Exp.Classes as C


--------------------------------------------------------------------------------
-- CHN
--------------------------------------------------------------------------------

cardinal ∷ (Integral α, Monoid s, IsString s) ⇒ α → Maybe s
cardinal = cardinalRepr ∘ struct

struct ∷ (Integral α, C.Unknown β, C.Lit β, C.Add β, C.Mul β) ⇒ α → β
struct = checkPos
       $ fix
       $ findRule (  0, lit           )
                [ ( 11, step 10 10 R L)
                , (100, lit           )
                ]
                   100

cardinalRepr ∷ (Monoid s, IsString s) ⇒ Exp → Maybe s
cardinalRepr = render defaultRepr
               { reprValue = \n → M.lookup n syms
               , reprAdd   = Just $ \_ _ _ → " pe "
               , reprMul   = Just $ \_ _ _ → " "
               }
    where
      syms =
          M.fromList
          [ (1, const "ikt")
          , (2, const "mokst")
          , (3, const "klone")
          , (4, const "lakit")
          , (5, const "kwinnum")
          , (6, const "taghum")
          , (7, const "sinamokst")
          , (8, const "stotekin")
          , (9, const "kwaist")
          , (10, const "tahtlum")
          , (100, const "tukamonuk")
          ]
