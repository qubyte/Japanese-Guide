for file in $*
    do
    pandoc -f markdown -t json $file | runhaskell handleRuby.hs html | pandoc -s -f json -t HTML5 -o ${file%.*}.html
done
exit 0