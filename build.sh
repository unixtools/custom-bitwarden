#!/bin/sh -x

VER=2025.1.0

echo "Building for '$BRAND' with suffix '$SUFFIX' and watermark '$LABEL'"

wget -N https://github.com/bitwarden/browser/releases/download/browser-v${VER}/dist-chrome-${VER}.zip
rm -rf browser${SUFFIX}
unzip -qd browser${SUFFIX} dist-chrome-${VER}.zip

(cd browser${SUFFIX} && find . -type f -exec perl -pi -e 's/"Bitwarden"/"Bitwarden - '${BRAND}'"/go;' {} \;)
(cd browser${SUFFIX} && find . -type f -exec perl -pi -e 's/"Bitwarden - Free Password Manager"/"Bitwarden - '${BRAND}'"/go;' {} \;)
(cd browser${SUFFIX} && find . -type f -exec perl -pi -e 's/"Bitwarden Password Manager"/"Bitwarden - '${BRAND}'"/go;' {} \;)
(cd browser${SUFFIX} && find . -type f -exec perl -pi -e 's{<title>Bitwarden</title>}{<title>Bitwarden - '${BRAND}'</title>}go;' {} \;)
rm -rf newimages
mkdir -p newimages
for file in browser${SUFFIX}/images/*; do
	case $file in
		*128)
			pointsize="-pointsize 24"
			;;
		*32*|*38*|*48*)
			pointsize="-pointsize 18"
			;;
		*16*|*18*|*19*)
			pointsize="-pointsize 10"
			;;
		*)
			pointsize=""
			;;
	esac
			
	composite $pointsize label:"${LABEL}" -gravity NorthWest $file newimages/`basename $file`
done
cp newimages/* browser${SUFFIX}/images/
rm -rf newimages
