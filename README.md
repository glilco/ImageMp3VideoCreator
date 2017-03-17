# ImageMp3VideoCreator
Creates a video from a static image and an mp3 audio file using ffmpeg.

This script was made for personal use and is not intended to be a generic converted. It can be changed to match your needs.

Depends on:
- Mp3 support
- ffmpeg
- sed
- Inkscape

The episodes-handler.sh reads convertlist.txt. Each line contains a filename of a mp3 file to be converted or the name of the previous episode (it is optional, just in case the episode name is different of the file name).

The mp3 file name must be in the following format:

001-Name-of-the-episode.mp3

Whith the 3 digit numbering, without spaces in the name and the '-' separator.

Mp3 files must be in the same directory of the script.

create-video.sh will create the video image based on DefaultCover.svg, replacing the placeholders with te actual episode data.

