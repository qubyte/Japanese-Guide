-- handleRuby.hs
-- The ruby element is new in HTML5, so only some browsers support it.
-- Webkit browsers and newer versions of IE should have no problem.
-- Firefox does not display ruby above kanji, but instead to the side
-- in brackets (this is the fall-back behaviour).
import Text.Pandoc

handleRuby :: Inline -> Inline
handleRuby (Link (Str ruby : []) ('-':kanji,_)) = RawInline "html" rubyHtml
  where rubyHtml = ("<ruby>" ++ kanji ++ "<rp>(</rp><rt>" ++ ruby ++ "</rt><rp>)</rp></ruby>")
handleRuby x = x

readDoc :: String -> Pandoc
readDoc = readMarkdown defaultParserState

writeDoc :: Pandoc -> String
writeDoc = writeMarkdown defaultWriterOptions

main :: IO ()
main = interact (writeDoc . bottomUp handleRuby . readDoc)