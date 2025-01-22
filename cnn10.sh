#!/bin/bash

export all_proxy=socks5://192.168.1.88:1080

cd /home/zhihuai1982/sata-14T/music/cnn10/

yt-dlp -x --audio-format mp3 \
    --embed-metadata \
    --break-on-existing \
    --max-downloads 5 \
    --download-archive videos.txt \
    --replace-in-metadata "title" " \|.*" "" \
    -o "raw-%(upload_date>%m%d)s-%(title)s.%(ext)s" \
    https://www.youtube.com/@CNN10/videos

# Iterate over all mp3 files in the current directory
for file in *.mp3; do
  # Extract the date part (MMDD) and the rest of the filename
  if [[ $file =~ ^raw-([0-9]{4})-(.*)\.mp3$ ]]; then
    mmdd="${BASH_REMATCH[1]}"
    title="${BASH_REMATCH[2]}"
    
    echo $mmdd
    echo $tile

    # Calculate the new year
    mmdd=$((10#$mmdd))
    new_year=$((2000 - mmdd))
    
    # Construct the new filename
    new_file="${new_year}-${mmdd}-${title}.mp3"
    
    # Rename the file
    mv "$file" "$new_file"

    metatitle="${new_file%.mp3}"
    
    # Update the title metadata
    eyeD3 --title="$metatitle" "$new_file"

  fi
done

