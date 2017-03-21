#!/bin/bash

for f in *.mp4
do
	FILENAME="${f%.*}"
	echo $FILENAME
	
	# Extracts audio from the video (for comparison)
	ffmpeg -i "$f" -vn -c:a copy "audios/$FILENAME.m4a"
	
	# Extracts audio from the video and removes silence
	ffmpeg -i "$f" -vn -af silenceremove=0:0:0:-1:1:-90dB:1 "audios/$FILENAME-silent.m4a"
	
	# Remount video with the new audio
    ffmpeg -i "$f" -i "audios/$FILENAME-silent.m4a" -map 0:v:0 -map 1:a:0 -c copy -shortest "reencoded/$FILENAME-silent.mp4"
done
