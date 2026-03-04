#!/bin/bash
PATH="/home/jonas/.scripts:$PATH" just > /dev/null 2>&1
pdftocairo -png -f 1 -l 1 "/home/jonas/stuff/whitepaper/build/FlexTail Whitepaper/FlexTail Whitepaper.pdf" /home/jonas/stuff/whitepaper/preview
