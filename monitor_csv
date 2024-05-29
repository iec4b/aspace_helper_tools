#!/bin/zsh
# monitor_csv
#
# This script is useful for monitoring changes to a "middleman" csv file, which
# is used as a holding place for csv rows to copy into the ASpace bulk upload
# spreadsheet, or similar applications ofo csv-based data.
#
# It resolves the common problem with combining csv rows from different files,
# differing row lengths, by invoking `xsv fixlengths`. It then selects only
# those columns specified by the argument, and prints them to screen in a table
# including a leading row number field.
#
# $1 is the file.
# $2 is the columns to select for printout to screen.
mon1="xsv fixlengths $2 | xsv select $3 | xsv table | nl"
mon2="watch 'xsv fixlengths $2 | xsv select $3 | xsv table | nl'"
mon3="watch 'xsv fixlengths $2 | xsv select $3 | xsv table | nl | tail -n 15'"
if [[ $1 == "--static" ]]; then
    eval $mon1
elif [[ $1 == "--dynamic" ]]; then
    eval $mon2
elif [[ $1 == "--tail" ]]; then
    eval $mon3
else
    echo "\$1 should be --static or --dynamic or --tail, \$2 should be the filename, \$3 should be the columns to show."
fi
