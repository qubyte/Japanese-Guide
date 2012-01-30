-- handleRuby.hs
import Text.Pandoc
import System.Environment (getArgs)
 
handleRuby :: String -> Inline -> Inline
handleRuby "html" (Link (Str ruby : []) ('-':kanji,_)) = RawInline "html"
 $ "<ruby>" ++ kanji ++ "<rp>(</rp><rt>" ++ ruby ++ "</rt><rp>)</rp></ruby>"
handleRuby "latex" (Link (Str ruby : []) ('-':kanji,_)) = RawInline "latex"
 $ "\\ruby{" ++ kanji ++ "}{" ++ ruby ++ "}"
handleRuby "kanji" (Link txt ('-':kanji,_)) = Str kanji
handleRuby "kana" (Link (Str ruby : []) ('-':kanji,_)) = Str ruby
handleRuby _ x = x
 
main :: IO ()
main = do
 args <- getArgs
 case args of
   [format] -> interact $ jsonFilter $ bottomUp (handleRuby format)
   _        -> error "Usage:  handleRuby (html|latex|kanji|kana)"
