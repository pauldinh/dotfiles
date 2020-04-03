if which sdcv >/dev/null 2>&1; then
    alias define='sdcv -c -u "Jargon File" -u "WordNet" -u "Free On-Line Dictionary of Computing" -u "dictd_www.dict.org_gcide" -u "Webster'\''s Revised Unabridged Dictionary (1913)"'
    #alias define='sdcv -c -u "WordNet"'
    alias thes='sdcv -c -u "Moby Thesaurus II"'
    alias jefine='sdcv -c -u "Jargon File"'
fi
