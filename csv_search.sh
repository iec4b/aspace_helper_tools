#!/bin/zsh
# csv_search3.sh
# The third version of the csv_search.sh script.

# A program to search strings accross a directory of bulk upload spreadsheets.
# Be careful to run the program in the same directory you are searching.
# 
# Loop through all the csv files in the directory.
# 
for i in *.csv; do
    # Define variable in preparation for the conditional -n statement below.
    # This will generate a view of each spreadsheet that only includes the title.
    # If the xsv command generates any error message, it is nullified (2>>...).
    # Deletes the first line of the xsv output, which is always the header row.
    # Adds a leading number field to the rows.
    # Executes a fuzzy search on the xsv output, ignoring the numbering field,
    # drawing on the entry of the $1 argument as the query.
    r=$(xsv select 'Title2' $i 2>>/dev/null | sed 1d | nl -v 0 | fzf --nth=2.. --filter $1)
    # $c and $p are used to generate the text-based borders for the output.
    # $c counts the number of characters in the filename $i.
    # $p adds 18 to the value of $c to account for additional hard-coded borders.
    c=${#i}
    p=$((c + 18))
    # The conditional below only works if the result of the query and pipe combo
    # in $r is NOT null. I believe this helps reduce the likelihood of empty sets
    # appearing in the search resuls (filename and text borders with no results
    # sandwiched in between.
    if [[ -n $r ]]; then
        # The next three rows create the upper text art borders for each iteration.
        printf '=%.0s' {1..$p}
        echo -e "\nvvvvvvvv $i vvvvvvvv"
        printf '-%.0s' {1..$p}
        echo -e "\n"
        # Print the results of the query $r to the screen.
        echo $r
        # Format the text art border below the query results for each iteration.
        echo ""
        printf '-%.0s' {1..$p}
        echo -e "\n^^^^^^^^ $i ^^^^^^^^"
        printf '=%.0s' {1..$p}
        echo -e "\n"
        echo ""

    fi
done
