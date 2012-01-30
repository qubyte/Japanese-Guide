for file in $*
    do
    pandoc -f markdown -t json $file | runhaskell handleRuby.hs latex | pandoc -s -f json -t latex --include-in-header=xelatex_header.tex -o ${file%.*}.tex
done
exit 0