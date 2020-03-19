#!/bin/sh

emconfigure ./configure \
  --disable-x86asm \
  --disable-inline-asm \
  --disable-doc \
  --disable-stripping \
  --nm="llvm-nm -g" \
  --ar=emar \
  --cc=emcc \
  --cxx=em++ \
  --objcc=emcc \
  --dep-cc=emcc \
  --ranlib=emranlib \
  --disable-autodetect \
  --disable-ffplay \
  --disable-ffprobe \
  --disable-network \
  --disable-everything \
  --enable-libvpx \

emmake make -j4

emcc \
    -Llibavcodec -Llibavdevice -Llibavfilter -Llibavformat -Llibavresample \
    -Llibavutil -Llibpostproc -Llibswscale -Llibswresample \
    -o ffmpeg.js \
    fftools/ffmpeg_opt.o fftools/ffmpeg_filter.o fftools/ffmpeg_hw.o \
    fftools/cmdutils.o fftools/ffmpeg.o \
    -lavdevice -lavfilter -lavformat -lavcodec -lswresample -lswscale -lavutil \
    -pthread -Oz

