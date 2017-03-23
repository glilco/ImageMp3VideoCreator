# Image Mp3 Video Creator

Creates a video from static image and mp3 audio file using ffmpeg.

This bash script was made for personal use and is not intended to be a generic converter. It can be changed to match your needs.

Depends on:
- Mp3 support
- ffmpeg
- sed
- Inkscape, ImageMagick or GraphicsMagick

To install all the dependencies in Ubuntu you can use the following command:
```
  sudo apt-get install ubuntu-restricted-extras ffmpeg sed inkscape
```
The **episodes-handler.sh** reads **convertlist.txt**. Each line contains a filename of a mp3 file to be converted or the name of the episode in the previous line (the name is optional, just in case the episode name is different of the file name).

The mp3 file name must be in the following format:
```
  001-Name-of-the-episode.mp3
```
Optionally the episode name can be placed in the next line

```
  001-Generic-Name.mp3
  Episode Name
```

Whith the 3 digit numbering, without spaces in the name and the '-' separator.

Mp3 files must be in the same directory of the script.

**create-video.sh** will create the video image based on **DefaultCover.svg**, replacing the placeholders with te actual episode data. The placeholders are *EPISODE_NUMBER* for the episode number and *EPISODE_NAME* for the episode name.

The image **DefaultCover.svg** can be altered but it must contain the placeholders needed by **create-video.sh**

Also includes **reencode.sh** script that trims silence from mp4 video files.
