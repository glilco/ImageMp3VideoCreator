#!/bin/bash

# Exit on error
set -e

# Test the number of parameters
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Invalid parameters"
    exit 1;
fi

# The first parameter must be the audio filename
AUDIO_NAME="$1"

ARRAY_EP=(${AUDIO_NAME//./ })
ARRAY_EP=(${ARRAY_EP[0]//-/ })

if [ ! -f "$AUDIO_NAME" ]; then
    echo -e "\033[0;31mFile $AUDIO_NAME not found!\033[0m"
    exit 1
fi

# Extracts the episode number from the first part of the filename
EP_NR=${ARRAY_EP[0]}
unset ARRAY_EP[0]

# Builds the filename whitspaces and without extension
EP_FILENAME=$(echo ${ARRAY_EP[@]})

echo "Episode number: $EP_NR"

# Uses the second parameter as the episode name, if provided
if [ $# -eq 2 ]; then
    EP_NAME="$2"
else
    EP_NAME="$EP_FILENAME"
fi

echo "Episode name: $EP_NAME"


# Makes a copy of the default SVG file to replace the placeholders with the real episode data
cp DefaultCover.svg "./converted/$EP_FILENAME.svg"
chmod 644 "./converted/$EP_FILENAME.svg"

sed -i "s/#EPISODE_NUMBER/#$EP_NR/g" "./converted/$EP_FILENAME.svg"
sed -i "s/EPISODE_NAME/$EP_NAME/g" "./converted/$EP_FILENAME.svg"

# Converts the SVG file to PNG to be used as input in ffmpeg
if hash inkscape 2>/dev/null; then
    inkscape -z -e "./converted/$EP_FILENAME.png" "./converted/$EP_FILENAME.svg" 
elif hash convert 2>/dev/null; then
    convert "./converted/$EP_FILENAME.svg"  "./converted/$EP_FILENAME.png"
elif hash gm 2>/dev/null; then
    gm convert "./converted/$EP_FILENAME.svg"  "./converted/$EP_FILENAME.png"
else
    echo "Can't convert SVG file to PNG file."
    exit 1
fi

# Creates the video using the created image and the provided audio
ffmpeg -loop 1 -framerate 1/25 -i "./converted/$EP_FILENAME.png" -i "$AUDIO_NAME" -vf "scale='min(1280,iw)':-2,format=yuv420p" -c:v libx264 -preset veryslow -crf 0 -c:a copy -shortest "./converted/Videos/$EP_NR-$EP_FILENAME.mkv"

