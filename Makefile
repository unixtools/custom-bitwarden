BROWSER=firefox

all: st hp ss sp

st:
	BROWSER=$(BROWSER) BRAND=MST LABEL=ST SUFFIX="-st" ./build.sh

hp:
	BROWSER=$(BROWSER) BRAND=HivePoint LABEL=HP SUFFIX="-hp" ./build.sh

ss:
	BROWSER=$(BROWSER) BRAND=Slickstream LABEL=SS SUFFIX="-ss" ./build.sh

sp:
	BROWSER=$(BROWSER) BRAND=Spirent LABEL=SP SUFFIX="-sp" ./build.sh
