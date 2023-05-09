BROWSER=firefox

all: st hp ss sp

st:
	BRAND=MST LABEL=ST SUFFIX="-st" ./build-$(BROWSER).sh

hp:
	BRAND=HivePoint LABEL=HP SUFFIX="-hp" ./build-$(BROWSER).sh

ss:
	BRAND=Slickstream LABEL=SS SUFFIX="-ss" ./build-$(BROWSER).sh

sp:
	BRAND=Spirent LABEL=SP SUFFIX="-sp" ./build-$(BROWSER).sh

