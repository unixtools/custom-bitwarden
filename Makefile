all: st hp

st:
	BRAND=MST LABEL=ST SUFFIX="-st" ./build.sh

hp:
	BRAND=HivePoint LABEL=HP SUFFIX="-hp" ./build.sh
