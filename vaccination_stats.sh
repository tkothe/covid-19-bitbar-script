#!/bin/bash
PATH=$PATH:/usr/local/bin 

# set COUNTRIES to comma separated list of ISO country codes
COUNTRIES=USA,DEU,CZE,LTU,LVA,AUT

export X=$(echo $COUNTRIES | sed -e 's/,/\",\"/g' -e 's/\(.*\)/"\1"/g')

Y=$(echo $COUNTRIES | tr , \~)

curl --silent https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.json | jq -r '[.[] | select([.iso_code] | inside([env.X] )) | {"country": .country } + .data[-1]] | .[] | "\(.country) 💉🧑: \(.people_vaccinated_per_hundred)% 💉📅/10^6 \(.daily_vaccinations_per_million) 💉📅 \(.daily_vaccinations) \(.date)"'

echo "---"
echo "stats | href=https://ourworldindata.org/grapher/share-people-vaccinated-covid?tab=chart&stackMode=absolute&time=earliest..latest&country=$Y&region=World"

