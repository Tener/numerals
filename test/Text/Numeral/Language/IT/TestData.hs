{-# LANGUAGE NoImplicitPrelude, OverloadedStrings, UnicodeSyntax #-}

module Text.Numeral.Language.IT.TestData (cardinals) where


--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------

-- from base:
import Data.String ( IsString )
import Prelude     ( Num, Integral )

-- from base-unicode-symobls:
import Prelude.Unicode ( (⋅) )

-- from numerals:
import Text.Numeral.Misc ( dec )


--------------------------------------------------------------------------------
-- IT
--------------------------------------------------------------------------------

cardinals ∷ (Num i, Integral i, IsString s) ⇒ [(i, s)]
cardinals =
  [ (0, "zero")
  , (1, "uno")
  , (2, "due")
  , (3, "tre")
  , (4, "quattro")
  , (5, "cinque")
  , (6, "sei")
  , (7, "sette")
  , (8, "otto")
  , (9, "nove")
  , (10, "dieci")
  , (11, "undici")
  , (12, "dodici")
  , (13, "tredici")
  , (14, "quattordici")
  , (15, "quindici")
  , (16, "sedici")
  , (17, "diciassette")
  , (18, "diciotto")
  , (19, "diciannove")
  , (20, "venti")
  , (21, "ventuno")
  , (22, "ventidue")
  , (23, "ventitré")
  , (24, "ventiquattro")
  , (25, "venticinque")
  , (26, "ventisei")
  , (27, "ventisette")
  , (28, "ventotto")
  , (29, "ventinove")
  , (30, "trenta")
  , (31, "trentuno")
  , (32, "trentadue")
  , (33, "trentatré")
  , (34, "trentaquattro")
  , (35, "trentacinque")
  , (36, "trentasei")
  , (37, "trentasette")
  , (38, "trentotto")
  , (39, "trentanove")
  , (40, "quaranta")
  , (41, "quarantuno")
  , (42, "quarantadue")
  , (43, "quarantatré")
  , (44, "quarantaquattro")
  , (45, "quarantacinque")
  , (46, "quarantasei")
  , (47, "quarantasette")
  , (48, "quarantotto")
  , (49, "quarantanove")
  , (50, "cinquanta")
  , (51, "cinquantuno")
  , (52, "cinquantadue")
  , (53, "cinquantatré")
  , (54, "cinquantaquattro")
  , (55, "cinquantacinque")
  , (56, "cinquantasei")
  , (57, "cinquantasette")
  , (58, "cinquantotto")
  , (59, "cinquantanove")
  , (60, "sessanta")
  , (61, "sessantuno")
  , (62, "sessantadue")
  , (63, "sessantatré")
  , (64, "sessantaquattro")
  , (65, "sessantacinque")
  , (66, "sessantasei")
  , (67, "sessantasette")
  , (68, "sessantotto")
  , (69, "sessantanove")
  , (70, "settanta")
  , (71, "settantuno")
  , (72, "settantadue")
  , (73, "settantatré")
  , (74, "settantaquattro")
  , (75, "settantacinque")
  , (76, "settantasei")
  , (77, "settantasette")
  , (78, "settantotto")
  , (79, "settantanove")
  , (80, "ottanta")
  , (81, "ottantuno")
  , (82, "ottantadue")
  , (83, "ottantatré")
  , (84, "ottantaquattro")
  , (85, "ottantacinque")
  , (86, "ottantasei")
  , (87, "ottantasette")
  , (88, "ottantotto")
  , (89, "ottantanove")
  , (90, "novanta")
  , (91, "novantuno")
  , (92, "novantadue")
  , (93, "novantatré")
  , (94, "novantaquattro")
  , (95, "novantacinque")
  , (96, "novantasei")
  , (97, "novantasette")
  , (98, "novantotto")
  , (99, "novantanove")
  , (100, "cento")
  , (108, "centotto")
  , (101, "centouno")
  , (150, "centocinquanta")
  , (180, "centottanta")
  , (188, "centottantotto")
  , (200, "duecento")
  , (208, "duecentotto")
  , (280, "duecentottanta")
  , (288, "duecentottantotto")
  , (300, "trecento")
  , (400, "quattrocento")
  , (456, "quattrocentocinquantasei")
  , (500, "cinquecento")
  , (600, "seicento")
  , (700, "settecento")
  , (800, "ottocento")
  , (900, "novecento")
  , (1000, "mille")
  , (1001, "milleuno")
  , (1002, "milledue")
  , (1100, "millecento")
  , (1200, "milleduecento")
  , (2000, "duemila")
  , (6827, "seimilaottocentoventisette")
  , (10000, "diecimila")
  , (11000, "undicimila")
  , (100000, "centomila")
  , (1 ⋅ dec 6, "milione")
  , (2 ⋅ dec 6, "due milioni")
  , (125 ⋅ dec 5, "dodici milioni cinquecentomila")
  , (43152 ⋅ dec 3, "quarantatré milioni centocinquantaduemila")
  , (132 ⋅ dec 6, "centotrentadue milioni")
  , (28375 ⋅ dec 4, "duecentottantatré milioni settecentocinquantamila")
  , (680 ⋅ dec 6, "seicentottanta milioni")
  , (1 ⋅ dec 9, "miliardo")
  , (2 ⋅ dec 9, "due miliardi")
  , (dec 12, "bilione")
  , (dec 15, "biliardo")
  , (dec 18, "trilione")
  , (dec 21, "triliardo")
  , (dec 24, "quadrilione")
  , (dec 27, "quadriliardo")
  , (dec 30, "quintilione")
  , (dec 33, "quintiliardo")
  , (dec 36, "sestilione")
  , (dec 39, "sestiliardo")
  , (dec 42, "settilione")
  , (dec 45, "settiliardo")
  , (dec 48, "ottilione")
  , (dec 51, "ottiliardo")
  , (dec 54, "nonilione")
  , (dec 57, "noniliardo")
  , (dec 60, "decilione")
  , (dec 63, "deciliardo")
  ]
