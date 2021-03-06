{-# LANGUAGE RecordWildCards #-}

import Data.Foldable     (for_)
import Test.Hspec        (Spec, describe, it, shouldBe)
import Test.Hspec.Runner (configFastFail, defaultConfig, hspecWith)

import Phone (number)

main :: IO ()
main = hspecWith defaultConfig { configFastFail = True } specs

specs :: Spec
specs = describe "number" $ for_ cases test
  where test Case {..} = it description $ number input `shouldBe` expected

data Case = Case { description ::       String
                 , input       ::       String
                 , expected    :: Maybe String
                 }

cases :: [Case]
cases
  = [ Case
      { description = "cleans the number"
      , input       = "(223) 456-7890"
      , expected    = Just "2234567890"
      }
    , Case
      { description = "cleans numbers with dots"
      , input       = "223.456.7890"
      , expected    = Just "2234567890"
      }
    , Case
      { description = "cleans numbers with multiple spaces"
      , input       = "223 456   7890   "
      , expected    = Just "2234567890"
      }
    , Case
      { description = "invalid when 9 digits"
      , input       = "123456789"
      , expected    = Nothing
      }
    , Case
      { description = "invalid when 11 digits does not start with a 1"
      , input       = "22234567890"
      , expected    = Nothing
      }
    , Case
      { description = "valid when 11 digits and starting with 1"
      , input       = "12234567890"
      , expected    = Just "2234567890"
      }
    , Case
      { description = "valid when 11 digits and starting with 1 even with punctuation"
      , input = "+1 (223) 456-7890"
      , expected = Just "2234567890"
      }
    , Case
      { description = "invalid when more than 11 digits"
      , input       = "321234567890"
      , expected    = Nothing
      }
    , Case
      { description = "invalid with letters"
      , input       = "123-abc-7890"
      , expected    = Nothing
      }
    , Case
      { description = "invalid with punctuations"
      , input       = "123-@:!-7890"
      , expected    = Nothing
      }
    , Case
      { description = "invalid if area code does not start with 2-9"
      , input       = "(123) 456-7890"
      , expected    = Nothing
      }
    , Case
      { description = "invalid if exchange code does not start with 2-9"
      , input       = "(223) 056-7890"
      , expected    = Nothing
      }
    ]
