#!/bin/sh -x

VER=2023.3.1

echo "Building for '$BRAND' with suffix '$SUFFIX' and watermark '$LABEL'"

wget -N https://github.com/bitwarden/browser/releases/download/browser-v${VER}/dist-firefox-${VER}.zip
rm -rf browser${SUFFIX}
unzip -qd browser${SUFFIX} dist-firefox-${VER}.zip
(cd browser${SUFFIX} && find . -type f -exec perl -pi -e 's/"Bitwarden"/"Bitwarden - '${BRAND}'"/go;' {} \;)
(cd browser${SUFFIX} && find . -type f -exec perl -pi -e 's/"Bitwarden - Free Password Manager"/"Bitwarden - '${BRAND}'"/go;' {} \;)
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
suffix_slug=`echo "$LABEL" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z`
jq ".applications.gecko.id = \"custom-bitwarden@${suffix_slug}\"" browser${SUFFIX}/manifest.json | sponge browser${SUFFIX}/manifest.json
