#!/bin/bash

URL=https://raw.githubusercontent.com/CSSEGISandData/COVID-19/web-data/data/cases_country.csv

# instead of using sed, maybe better use this FPAT stuff (didn't get it to work immediately) http://www.gnu.org/software/gawk/manual/html_node/Splitting-By-Content.html
# https://stackoverflow.com/questions/3138363/can-awk-deal-with-csv-file-that-contains-comma-inside-a-quoted-field

curl --silent $URL  | sed 's/\Korea, South\"/South Korea/g'| awk -F, ' FNR == 1 {next} {confirmed += $5; deaths += $6} /Germany|Czech|Italy|Spain|France|US|Austria/ { countries = countries ($1 "\t Confirmed: " $5 "\t, Deaths: " $6 "\n")} END {print "Confirmed: " confirmed ", Deaths: " deaths; print "---\n" countries}'
