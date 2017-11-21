#!/bin/bash
echo "IMPORTANT DO NOT USE A PROXY THE SERVER MAY REJECT YOUR request!"
echo "Insert the name of the Anime to look for"
read anime
echo "original result $anime"
modified=$(echo "$anime" | sed  's/ /%20/g')
echo "result modified to add to the query $modified"
echo "_________________________________________________________________"
wget  https://ww3.gogoanime.io//search.html?keyword=$modified
LIST=$(cat search.html\?keyword\=$modified | grep "category/" | sed 's/"//g'  | grep "<p class=name" |  sed 's/<p class=name>//g' | sed 's/[/]//g'  | sed  's/<a href=//g' | sed 's/category//g' | sed 's/title=//g' | sed 's/<a>//g' | sed 's/<p>//g' | sed 's/>/ /g' | tr ' ' '\n' | grep [-])
cat search.html\?keyword\=$modified | grep "category/" | sed 's/"//g'  | grep "<p class=name" |  sed 's/<p class=name>//g' | sed 's/[/]//g'  | sed  's/<a href=//g' | sed 's/category//g' | sed 's/title=//g' | sed 's/<a>//g' | sed 's/<p>//g' | sed 's/>/ /g' | tr ' ' '\n' | grep [-] | cat -n
echo "__________________________________________________________________"
echo "TYPE THE ANIME YOU WANT TO DOWNLOAD!"
read num
anime=$(echo "$LIST" | sed "${num}q;d")
echo "_________________________________"
echo "Anime to download ->  $anime"
wget https://ww3.gogoanime.io/category/$anime
echo "_________________________________"
echo "AVAILABLE EPISODES -> $num"
echo "________________________________________"
echo "Which episode do you want to download?"
echo "1 Choose an episode"
echo "2 ALL -> Downloads All the availables"
read ep
echo "Downloading $anime Episode $ep"
wget "https://ww3.gogoanime.io/$anime-episode-$ep"
LINK=$(cat "$anime-episode-$ep" | grep -w "https://vidstream.com*"  |  sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' | grep https)
echo "Link of the Episodes $LINK"
wget "$LINK"
echo "THIS ARE THE AVAILABLES LINKS SELECT 1"
DL=$(echo $LINK | tr '/' '\n' | grep "SUB")
ALL=$(cat $DL | grep https | sed 's/href=//g' | sed 's/"//g' | sed -s 's/<link rel=stylesheet//g' | sed 's/>Download//g' | grep "https://lh")
cat -n  $DL | grep https | sed 's/href=//g' | sed 's/"//g' | sed -s 's/<link rel=stylesheet//g' | sed 's/>Download//g' | grep "https://lh"
echo "TYPE THE QUALITY"
read num
download=$(echo "$ALL" | sed "${num}q;d")
echo "Downloading ANIME -> $download"
wget $download -O "$anime-episode-$ep.mp4"
#echo "result modified to add to the query $modified"
#echo "Checking on the official page!"
#wget https://ww3.gogoanime.io/category/$modified
#echo "downloading the file!!!"
#echo "ERRRO DOWNLOADING THE FILE CHECK YOUR CONNECTION OR PROXY!"
#echo "Sorry oni-chan!! >.<"
#echo "File downloaded successfully 7u7!!!"
