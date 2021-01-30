#!/bin/bash
apikey="INSERTNASAAPIKEYHERE"

year="2021"
month="01"
day="01"

if [ -z "$1" ]
  then
    date=$year-$month-$day
else
    date="$1"
fi

naturalrawdata=$(curl -L https://api.nasa.gov/EPIC/api/natural/date/$date?api_key=$apikey)
echo $naturalrawdata

parsednaturalrawdata1=$(echo $naturalrawdata | awk '{sub(/","version":.*/,x)}1')
parsednaturalrawdata2=$(echo $parsednaturalrawdata1 | sed -nr '/"image":"/ s/.*"image":"([^"]+).*/\1/p')
echo $parsednaturalrawdata2

echo $(curl https://epic.gsfc.nasa.gov/archive/natural/"${date//-//}"/jpg/$parsednaturalrawdata2.jpg > result.jpg)
