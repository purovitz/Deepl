#!/bin/bash


# API KEY
apikey=XXX

# File Name
path_file=$1

echo " "

if [ -e "$path_file" ] ; then
	read_file=$(cat "$path_file")
else
	echo "File doesnt exist"
fi


if [ -n "$1" ] ; then
	text=$(echo "$read_file" | sed 's/ /%20/g')
else
	echo "Provide text to be translated: "
	read -r input_text
	text=$(echo "$input_text" | sed 's/ /%20/g')
fi



translator=$(curl -X POST 'https://api-free.deepl.com/v2/translate' \
	-H 'Authorization: DeepL-Auth-Key d63c6635-9ed2-fdf3-714d-23400efd57d0:fx' \
	-d 'text='$text'' \
	-d 'target_lang=EN')


echo ""

language=$(echo "$translator" | jq '.translations[].detected_source_language' )
translated_text=$(echo "$translator" | jq '.translations[].text' )


if [ -e "${path_file}_eng" ] ; then
        echo "This file already exists"
else
        echo "$translated_text" > "${path_file}_eng"
fi




echo ""
echo "---------------------------------------------------------------------------------------------------"

echo "Text entered: "
if [ -n "$1" ] ; then
        echo "$read_file"
else
        echo "$input_text"
fi

echo "---------------------------------------------------------------------------------------------------"


echo " "
echo "Language detected: $language"
echo " " 

echo "---------------------------------------------------------------------------------------------------"


echo "Translated text: " 
echo "${translated_text:1:-1}"
echo "---------------------------------------------------------------------------------------------------"
echo " "

