# photoframe
Adjust photo resolution and orientation to fit a photoframe

== Background ==
My household recently came into possession of two [Motion Video Frames](https://www.wordsinmotionco.com/products/motion-video-frame), digital photo frames sold by [Words in Motion](https://www.wordsinmotionco.com/). They are 854x480px LCD screens with 2GB memory accessible via a USB micro B port, alllowing easy upload from a computer, and they can display files of the following types:
* MP4
* AVI
* MOV
* WMV
* JPG
* BMP
* PMG

So far, I have found they suffer from two main problems:
1. They automatically stretch / squeeze images to fit the current resolution (854x480 px when placed horizontally / in landscape more, 480x854px when placed vertically / in portrait mode). This leads to extremely ugly display for images whose resolution is not the same ratio (1:1.90 / 1.90:1).
2. They cannot display images stored in using Apple's High Efficiency File Format (HEIC)

These problems can be solved manually, one file at a time, but it is tedious to do so. [ImageMagick](https://imagemagick.org/index.php) is a sophisticated tool that allows one to batch conversion work.

== OS ==
This is a bash script. I have tested and use it under Cygwin on Windows; it ought to work without too many changes on real Linux systems, MinGW, etc.

== Prerequisites ==
* bash shell
* [ImageMagick](https://imagemagick.org/index.php) must be in the path
* The script fix-photos.sh must be in the path, and executable

== Use ==
```bash
fix-photos.sh landscape|portrait source-image-directory [[--rotate [[rotation-angle]] ]]
```
where
1. The first positional paramater, landscape or portrait, indicates whether the converted image should have the longer side on the top & bottom (landscape) or the sides (portrait)
2. The second position parameter is the directory containing the images to convert. **Note** that the converted images will be placed in a sub-directory of the current directory named "out".
3. An optional argument, --rotate, with an optional rotation-angle indicating that the output image should be rotated by the given angle (in degrees). If no rotation-angle is specified, the image is rotated by 90 degrees.

== Use cases ==
All of the uses cases below assume that the set of images to convert are in a sub-directory of the current directory named "in".
=== Converting from portrait images to landscape images ===
```bash
fix-photos.sh landscape in --rotate
```
=== Converting from landscape images to landscape images ===
```bash
fix-photos.sh landscape in
```
=== Converting from landscape images to portrait images ===
```bash
fix-photos.sh portrait in --rotate
```
=== Converting from portrait images to portrait images ===
```bash
fix-photos.sh portrait in
```

== Tips ==
1. It can be convenient to segregate images needing rotation from those which don't by putting them in separate direcotries, e.g. "in-no-rotate" and "in-rotate", and then convert them like:
```bash
fix-photos.sh portrait in-no-rotate
fix-photos.sh portrait in-rotate --rotate
```
This will put all converted images in the "out" directory.
