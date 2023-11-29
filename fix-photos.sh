#!/bin/bash

# These are the horizontal and vertical numbers of pixels for the target device.
# In my case, this is for the Motion Video Frame
declare -r long_resolution_px=854
declare -r short_resolution_px=480

# Check for valid arguments
if [[ $# -lt 2 ]] || ( [[ "$1" != "landscape" ]] && [[ "$1" != "portrait" ]] ) || [[ ! -d "$2" ]] || ( [[ $# -gt 3 ]] && [[ "$3" != "--rotate" ]] ) || [[ $# -gt 4 ]]; then
	cat <<-EOT
	Use:
	        $0 landscape source-directory [--rotate [angle]]
	or
	        $0 portrait source-directory [--rotate [angle]]
	EOT
	exit 1
fi

# Get the output resolution based on whether the first positional paameter is "landscape" or "portrait"
declare -r operation="$1"
if [[ "${operation}" == "landscape" ]]; then
	declare -r resolution="${long_resolution_px}x${short_resolution_px}"
elif [[ "${operation}" == "portrait" ]]; then
	declare -r resolution="${short_resolution_px}x${long_resolution_px}"
fi

# Get the input directory
declare -r input_dir="$2"

# Get the rotation to apply to the image, if any:
# "--rotate" gives a rotation of 90 degrees
# "--rotate angle" gives a rotation of angle degrees
if [[ $# -gt 2 ]]; then
	if [[ $# -gt 3 ]]; then
		declare -r rotation="-rotate ${4}"
		echo "Images will be rotated by {4} degrees"
	else
		declare -r rotation="-rotate 90"
		echo "Images will be rotated by 90 degrees"
	fi
else
	declare -r rotation=
	echo "Images will not be rotated"
fi

# Create the output directory if needed.
if [[ ! -d out ]]; then
	mkdir out
	if [[ "$?" -ne 0 ]]; then
		exit 1;
	fi
fi

process_file()
{
	declare -r fn=$(basename "$1")
	declare -r extension=${fn##*.}
	if [ "$extension" == "heic" ]; then
		declare -r delegate="heic:"
	else
		declare -r delegate=""
	fi

	convert "${delegate}$1[0]" ${rotation} -resize "${resolution}" -background black -gravity center -extent "${resolution}" "out/${fn%.*}.jpg"
}

for filename in "${input_dir}"/*; do
	process_file "${filename}"
done
