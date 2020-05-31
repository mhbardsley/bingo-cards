# bingo-cards

## PREREQUISITES
- SWI-Prolog (https://www.swi-prolog.org/)

## HOW TO RUN
- Input parameters as given in input folder (currently just has dummy data)
    - config.txt
        - no of columns
        - no of rows
        - no of cards
    - list.txt
        - line separated list of bingo items (songs/numbers/countries, etc)
- Running the program
    - Once you have SWI-Prolog installed and as a `$PATH` environment variable, and input parameters as desired:
    - If you are a Windows user, just double-click the file `run.bat`
    - If it doesn't work, or you are a non-Windows user:
        - Navigate to this directory (via command prompt/bash)
        - Run `swipl cards.pl`
        - Cards will then appear in the output folder