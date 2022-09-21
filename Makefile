all: st hp ss sp

st:
	BRAND=MST LABEL=ST SUFFIX="-st" ./build.sh

hp:
	BRAND=HivePoint LABEL=HP SUFFIX="-hp" ./build.sh

ss:
	BRAND=Slickstream LABEL=SS SUFFIX="-ss" ./build.sh

sp:
	BRAND=Spirent LABEL=SP SUFFIX="-sp" ./build.sh

