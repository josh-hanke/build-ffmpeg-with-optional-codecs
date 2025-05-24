# build-ffmpeg-with-optional-codecs
A bash script to automatically download and compile FFMPEG with fdkaac and mp3lame on Debian/Ubuntu. I've tested with Kubuntu 22.04 and Mint 22, other distros are untested so your mileage may vary.

### Prerequisits
None! (I'm pretty sure)

### Usage
Just download, set permissions and run as admin.
```
git clone https://github.com/josh-hanke/build-ffmpeg-with-optional-codecs
cd build-ffmpeg-with-optional-codecs
sudo chmod +x build-ffmpeg.sh
sudo ./build-ffmpeg.sh
```
Defaults to installing to /usr/local, I'm planning on adding an install directory argument at some point in the future.

### Credits

I made this script based on the ffmpeg compilation guide (http://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu) and a guide I found on Tecmint (https://www.tecmint.com/install-ffmpeg-in-linux/). I'm sure I used another guide or two an I will link them when I find them.
