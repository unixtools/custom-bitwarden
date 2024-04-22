#!/bin/sh -x

#VER=2024.4.1

VER=$(curl --silent "https://api.github.com/repos/bitwarden/clients/releases" |	# get latest browser release version number
	grep -m 1 '"tag_name": "browser-v' |
	sed -E 's/.*"browser-v([^"]+)".*/\1/')

echo "Building '$BROWSER' extension for '$BRAND' with suffix '$SUFFIX' and watermark '$LABEL', BitWarden release ${VER}"

wget -N https://github.com/bitwarden/clients/releases/download/browser-v${VER}/dist-${BROWSER}-${VER}.zip
rm -rf ${BROWSER}${SUFFIX}
unzip -qd ${BROWSER}${SUFFIX} dist-${BROWSER}-${VER}.zip
(cd ${BROWSER}${SUFFIX} && find . -type f -exec perl -pi -e 's/"Bitwarden"/"Bitwarden - '${BRAND}'"/go;' {} \;)
(cd ${BROWSER}${SUFFIX} && find . -type f -exec perl -pi -e 's/"Bitwarden - Free Password Manager"/"Bitwarden - '${BRAND}'"/go;' {} \;)
(cd ${BROWSER}${SUFFIX} && find . -type f -exec perl -pi -e 's{<title>Bitwarden</title>}{<title>Bitwarden - '${BRAND}'</title>}go;' {} \;)
rm -rf newimages
mkdir -p newimages
for file in ${BROWSER}${SUFFIX}/images/*; do
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
cp newimages/* ${BROWSER}${SUFFIX}/images/
rm -rf newimages

if [ "$BROWSER" = "firefox" ]; then
	# Firefox extensions require a unique ID in manifest.json at applications.gecko.id
	suffix_slug=`echo "$LABEL" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z`
	sed -i "s/\"id\": \"{.*}\"/\"id\": \"$suffix_slug@mst\.edu\""/ ${BROWSER}${SUFFIX}/manifest.json
	
	# Firefox extensions must be packaged as .xpi files
	rm bitwarden-${BROWSER}${SUFFIX}.xpi
	(cd ${BROWSER}${SUFFIX}; zip -r --compression-method store ../bitwarden-${BROWSER}${SUFFIX}.zip ./)
	mv bitwarden-${BROWSER}${SUFFIX}.zip bitwarden-${BROWSER}${SUFFIX}.xpi
	rm -rf ${BROWSER}${SUFFIX}

	# Note this extension will be unsigned. Toggle xpinstall.signatures.required in about:config under Developer Edition, Nightly, or ESR to allow install
fi