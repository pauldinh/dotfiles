#!/bin/bash

if which sdcv >/dev/null 2>&1; then
    alias define='sdcv -c'
    alias jefine='sdcv -c -u "Jargon File"'
fi
