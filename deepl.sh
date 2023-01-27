#!/bin/bash


# API KEY

apikey=XXX

echo "Podaj tekst do przetlumaczenia"
read -r text

text=$(echo "$text" | sed 's/ /%20/g') 
# text=$(echo "$text" | sed 's/$/%0A/g')
echo $text


translator=$(curl -X POST 'https://api-free.deepl.com/v2/translate' \
	-H 'Authorization: DeepL-Auth-Key d63c6635-9ed2-fdf3-714d-23400efd57d0:fx' \
	-d 'text='$text'' \
	-d 'target_lang=EN')

echo ""
echo $translator
language=$(echo "$translator" | jq '.translations[].detected_source_language' )
translated_text=$(echo "$translator" | jq '.translations[].text' )

echo ""
echo "Text entered: $text"
echo "Language detected: $language"
echo "Translated text: $translated_text"
echo ""

# Process command line options
while getopts ":t:" opt; do
  case $opt in
    l) text="$OPTARG" ;;
    \?) echo "Invalid option: -$OPTARG" >&2
        exit 1 ;;
  esac
done

