#!/bin/bash

# Ensure the script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo: sudo ./build_ffmpeg.sh"
  exit 1
fi

echo "Updating apt packages..."
sudo apt update
echo "Installing build dependencies..."
sudo apt -y install autoconf automake build-essential nasm libass-dev libfreetype6-dev libtheora-dev libtool libvorbis-dev pkg-config texinfo zlib1g-dev libfdk-aac-dev libmp3lame-dev yasm

# Create a temporary directory for sources
srcDir="/usr/local/src/ffmpeg_build_temp"
echo "Creating source directory: $srcDir"
mkdir -p "$srcDir"
cd "$srcDir" || { echo "Failed to change directory to $srcDir"; exit 1; }

echo "Downloading FFmpeg snapshot..."
wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
echo "Extracting FFmpeg..."
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg || { echo "Failed to change directory to ffmpeg"; exit 1; }

echo "Configuring FFmpeg for system-wide installation..."
# Configure FFmpeg build with some optional components
PKG_CONFIG_PATH="/usr/local/lib/pkgconfig" ./configure \
--prefix="/usr/local" \
--pkg-config-flags="--static" \
--extra-cflags="-I/usr/local/include" \
--extra-ldflags="-L/usr/local/lib" \
--enable-libass \
--enable-libfdk-aac \
--enable-libfreetype \
--enable-libtheora \
--enable-libvorbis \
--enable-libmp3lame \
--enable-nonfree \
--enable-gpl

echo "Compiling FFmpeg (this may take a while)..."
# Build using all available CPU cores
make -j$(nproc)

echo "Installing FFmpeg..."
make install

echo "Cleaning up build files..."
make distclean

# Clean up the source directory
echo "Removing temporary source directory: $srcDir"
cd /
rm -dR "$srcDir"

echo "Updating command hash table..."
# hash -r is useful for the current shell session to recognize new commands
hash -r

echo "FFmpeg installation complete. Please verify by running 'ffmpeg -version'."
echo "If 'ffmpeg' is not found, you might need to open a new terminal session."
