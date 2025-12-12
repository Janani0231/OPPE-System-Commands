#!/usr/bin/env bash
# Usage: N=3 DELIMITER=',' ./script.sh < input.txt
# Reconstruct records with N fields each, using DELIMITER between fields.

awk -v N="$N" -v DELIM="$DELIMITER" '
# Global counter of how many fields have been output in the current record
BEGIN { count = 0 }

{
    # For each input line, split into tokens using DELIM as the separator.
    # split(s, arr, sep) uses sep as a regex. For common delimiters like "," or "|"
    # this works fine.
    num = split($0, tokens, DELIM)

    for (i = 1; i <= num; ++i) {
        # print token
        printf "%s", tokens[i]
        count++

        # If we have printed N fields, end the record (newline) and reset counter.
        if (count % N == 0) {
            printf "\n"
        } else {
            # Otherwise print the field delimiter between fields in the same record
            printf "%s", DELIM
        }
    }
}

END {
    # If the input ended in the middle of a record (count % N != 0),
    # we still printed delimiters between tokens; append a final newline
    # so the output ends with a newline.
    if (count % N != 0) {
        printf "\n"
    }
}
' 
