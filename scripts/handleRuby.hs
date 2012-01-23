-- handleRuby.hs
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