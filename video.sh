#!/bin/bash

# Nome dos arquivos de entrada
audio_file="seu_audio.mp3"
#video_file="seu_video.mp4"
video_file="marcus.mp4"


ex="greenscreen.mp4"

# Apply chromakey
ffmpeg -i $video_file -i $ex -filter_complex '[1:v]colorkey=0x00FF00:0.1:1[ckout];[0:v][ckout]overlay[out]' -map '[out]' -t $(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $video_file) ./result/final_output.mp4



#REVERSELOOP

  ffmpeg -i "./result/final_output.mp4" \
         -filter_complex "[0]reverse[r];[0][r]concat,loop=5:250,setpts=N/25/TB" ./result/output.mp4


#LOOP
ffmpeg -stream_loop -1 -i "./result/output.mp4" -i $audio_file -map 0:v:0 -map 1:a:0 -c copy -t "$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$audio_file")" ./result/outputfinal.mp4

rm "./result/output.mp4"
rm "./result/final_output.mp4"

