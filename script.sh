#!/bin/bash

echo "
=== Discord Auto Updater Powered by Gromitmugs 🫡 ===
"
echo "
           *((//* //******,,..,,,,,,,,,,,**//(
      &&&#(&&&&&(/(/***********************//((&
    &&&&&&&&(**(&((//****,,...,**.....,****//(/&&
  &&&&&&%.        (//****,,@@@&,*,@@@&,****//(&&&
 %&&&&&%          (/***********,,**********//(&&%
 &&&&&%,          */***********,*,**,******//(&&
 &&&&&#.          */********,,,,,,,,********/(/&&
 &&&&&&/         */********,,,,,,,,,,,*******/(&&
 &&&&&&&#.      //********,,,,,,,******,,,****/(&&
  %&&&&&&&%/,  (//*********@&&@&&@&&/**********/*&
   (&&&&&&&&&&#(//*******&@@@&@&@@@@&@@********/#&
     #&&&&&&&&%///******&@@@@@@@@@@@@&&@*******/*(
        %&&&&&&*//******&&@@@@@@@@@@&@&&&*******
                ////*****&&@@&&&&&@@@@&&/******
                  /////////&&&@@@@@&&(///////
          ..,,,,, */#(///////(((((((((((((#(/.*
"



echo ==== Checking Updates 🫡 ====; echo;

# checking existance
if ! command -v discord &> /dev/null
then
    echo Discord could not be found😔
    exit 1
fi

# downloading stuff
download_link=$(curl -s 'https://discord.com/api/download?platform=linux&format=deb' | grep -E -io 'href="[^\"]+"' | awk -F\" '{print$2}')
download_filename=$(basename $download_link)

# checking latest version
latest_version=$(echo $download_filename | grep -oP 'discord-\K\d+\.\d+\.\d+(?=\.deb)')

# checking local version
discord_path=$(dirname $(realpath $(which discord)))
discord_path+="/resources/build_info.json"
local_version=$(cat $discord_path | jq -r '.version')

# printing versions
echo "• Discord latest version is $latest_version"
echo "• The local Discord version is $local_version"

if [[ "$latest_version" == "$local_version" ]]; then
    echo "
***Discord is already up-to-date😔***.
"
    exit 0
fi


echo; echo ==== Downloading $download_filename 🫡 ===; echo;

# download installer
echo • Download and Install Newer Discord Version 🫡
echo • This may require sudo privillages 🫡

wget --trust-server-names $download_link &>/dev/null

# # remove old discord package
sudo dpkg -r discord &>/dev/null
sudo dpkg -i $download_filename &>/dev/null

rm $download_filename

echo "
***Installation Completed 🫡 ***.
"

