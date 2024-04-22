all: st hp sp

st:
	BROWSER=chrome BRAND=MST LABEL=ST SUFFIX="-st" ./build.sh
	BROWSER=firefox  BRAND=MST LABEL=ST SUFFIX="-st" ./build.sh

hp:
	BROWSER=chrome BRAND=HivePoint LABEL=HP SUFFIX="-hp" ./build.sh
	BROWSER=firefox BRAND=HivePoint LABEL=HP SUFFIX="-hp" ./build.sh

sp:
	BROWSER=chrome BRAND=Spirent LABEL=SP SUFFIX="-sp" ./build.sh
	BROWSER=firefox BRAND=Spirent LABEL=SP SUFFIX="-sp" ./build.sh
