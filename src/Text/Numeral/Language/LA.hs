{-# LANGUAGE NoImplicitPrelude
           , OverloadedStrings
           , PackageImports
           , UnicodeSyntax
  #-}

{-|
[@ISO639-1@]        la

[@ISO639-2B@]       lat

[@ISO639-3@]        lat

[@Native name@]     Latine

[@English name@]    Latin
-}

module Text.Numeral.Language.LA
    ( cardinal
    , struct
    ) where


--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------

import "base" Data.Bool     ( otherwise )
import "base" Data.Function ( ($), const, fix )
import "base" Data.List     ( concat )
import "base" Data.Maybe    ( Maybe(Just) )
import "base" Data.Monoid   ( Monoid )
import "base" Data.String   ( IsString )
import "base" Prelude       ( Integral, Num, (+) )
import "base-unicode-symbols" Data.Function.Unicode ( (∘) )
import "base-unicode-symbols" Data.List.Unicode     ( (∈) )
import "base-unicode-symbols" Data.Ord.Unicode      ( (≤) )
import "base-unicode-symbols" Data.Monoid.Unicode   ( (⊕) )
import qualified "containers" Data.Map as M ( fromList, lookup )
import           "numerals-base" Text.Numeral
import qualified "numerals-base" Text.Numeral.Exp.Classes as C


--------------------------------------------------------------------------------
-- LA
--------------------------------------------------------------------------------

{-
Sources:
  http://www.informalmusic.com/latinsoc/latnum.html
  http://www.sf.airnet.ne.jp/~ts/language/number/latin.html
-}

cardinal ∷ (Integral α, Monoid s, IsString s) ⇒ α → Maybe s
cardinal = cardinalRepr ∘ struct

struct ∷ (Integral α, C.Unknown β, C.Lit β, C.Add β, C.Sub β, C.Mul β) ⇒ α → β
struct = checkPos
       $ fix
       $ findRule ( 0, lit)
                  ( [ (11, add 10 L)
                    , (18, sub 20)
                    ]
                  ⊕ concat [ [ (n,   mul 10 R L)
                             , (n+8, sub $ n+10)
                             ]
                           | n ← [20,30..90]
                           ]
                  ⊕ [ ( 100, step 100 10 R L)
                    , (1000, lit)
                    ]
                  )
                  1000

cardinalRepr ∷ (Monoid s, IsString s) ⇒ Exp → Maybe s
cardinalRepr = render defaultRepr
               { reprValue = \n → M.lookup n syms
               , reprAdd   = Just (⊞)
               , reprMul   = Just (⊡)
               , reprSub   = Just $ \_ _ _ → "dē"
               , reprNeg   = Just $ \_ _   → "minus "
               }
    where
      ((_ `Mul` Lit _) ⊞ _) _ = " "
      (_               ⊞ _) _ = ""

      (_ ⊡ Lit n) _ | n ≤ 100 = ""
      (_ ⊡ _    ) _           = " "

      syms =
          M.fromList
          [ (0, const "nihil")
          , (1, \c → case c of
                       CtxAdd _ (Lit 10)  _ → "ūn"
                       CtxSub _ _         _ → "ūn"
                       _                    → "ūnus"
            )
          , (2, \c → case c of
                       CtxMul _ (Lit 10)  _ → "vī"
                       CtxMul _ (Lit 100) _ → "du"
                       _                    → "duo"
            )
          , (3, \c → case c of
                       CtxAdd _ (Lit 10)  _ → "trē"
                       CtxMul _ (Lit 10)  _ → "trī"
                       CtxMul _ (Lit 100) _ → "tre"
                       _                    → "trēs"
            )
          , (4, \c → case c of
                       CtxMul _ (Lit 10)  _ → "quadrā"
                       CtxMul _ (Lit 100) _ → "quadrin"
                       _                    → "quattuor"
            )
          , (5, \c → case c of
                       CtxAdd _ (Lit 10)  _ → "quīn"
                       CtxMul _ (Lit 10)  _ → "quīnquā"
                       CtxMul _ (Lit 100) _ → "quīn"
                       _                    → "quīnque"
            )
          , (6, \c → case c of
                       CtxAdd _ (Lit 10)  _ → "sē"
                       CtxMul _ (Lit 10)  _ → "sexā"
                       CtxMul _ (Lit 100) _ → "ses"
                       _                    → "sex"
            )
          , (7, \c → case c of
                       CtxAdd _ (Lit 10)  _ → "septen"
                       CtxMul _ (Lit 10)  _ → "septuā"
                       CtxMul _ (Lit 100) _ → "septin"
                       _                    → "septem"
            )
          , (8, \c → case c of
                       CtxMul _ (Lit 100) _ → "octin"
                       _                    → "octō"
            )
          , (9, \c → case c of
                       CtxMul _ (Lit 10)  _ → "nōnā"
                       CtxMul _ (Lit 100) _ → "nōn"
                       _                    → "novem"
            )
          , (10, \c → case c of
                        CtxAdd {}           → "decim"
                        CtxMul _ (Lit 2)  _ → "gintī"
                        CtxMul {}           → "gintā"
                        _                   → "decem"
            )
          , (100, \c → case c of
                         CtxMul _ (Lit n) _
                             | n ∈ [2,3,6] → "centī"
                             | otherwise   → "gentī"
                         _                 → "centum"
            )
          , (1000, \c → case c of
                          CtxMul {} → "milia"
                          _         → "mīlle"
            )
          ]
