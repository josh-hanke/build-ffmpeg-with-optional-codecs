#!/bin/bash

sudo apt update
sudo apt -y install autoconf automake build-essential nasm libass-dev libfreetype6-dev libtheora-dev libtool libvorbis-dev pkg-config texinfo zlib1g-dev libfdk-aac-dev libmp3lame-dev yasm
mkdir ffmpeg_sources
cd ffmpeg_sources
wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
--prefix="$HOME/ffmpeg_build" \
--pkg-config-flags="--static" \
--extra-cflags="-I$HOME/ffmpeg_build/include" \
--extra-ldflags="-L$HOME/ffmpeg_build/lib" \
--bindir="$HOME/bin" \
--enable-libass \
--enable-libfdk-aac \
--enable-libfreetype \
--enable-libtheora \
--enable-libvorbis \
--enable-libmp3lame \
--enable-nonfree \
--enable-gpl
PATH="$HOME/bin:$PATH" make
make install
make distclean
hash -r
