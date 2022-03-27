#!/bin/bash

help () {
  printf "Parchos Arts convert script \n"
  printf "Syntax: convert_to_all_size file [-h]\n"
  printf "* file:\t\t\t\t A mandatory argument and must be a image\n"
  printf "* -h: \t\t\t\t Show this message\n"
}

if [ "$1" == "" ];then
  help
  exit 1
fi

filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"
dirname="$(dirname $(readlink -e $1))"

sizes=( '1600x1200'
  '1280x1024'
  '440x247'
  '1080x1920'
  '1680x1050'
  '1024x768'
  '1366x768'
  '3200x2000'
  '3200x1800'
  '2560x1600'
  '3840x2160'
  '720x1440'
  '5120x2880'
  '2560x1440'
  '1280x800'
  '360x720'
  '1920x1200'
  '1440x900'
  '1920x1080'
)

if file "$1" | grep -qE 'image|bitmap'; then
  mkdir -p $dirname/$filename/sizes
  for size in ${sizes[@]};do
    echo "converting to $size..."
    convert $1 -resize $size\> $dirname/$filename/sizes/$size.$extension
  done
  
else
  echo "The $1 file is not a photo, please use a photo."
  exit 1
fi
