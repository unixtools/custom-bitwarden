all: st hp sp

st:
	BRAND=MST LABEL=ST SUFFIX="-st" ./build.sh

hp:
	BRAND=HivePoint LABEL=HP SUFFIX="-hp" ./build.sh

sp:
	BRAND=Spirent LABEL=SP SUFFIX="-sp" ./build.sh

