all: st hp nn

st:
	BRAND=MST LABEL=ST SUFFIX="-st" ./build.sh

hp:
	BRAND=HivePoint LABEL=HP SUFFIX="-hp" ./build.sh

nn:
	BRAND=Neulinger LABEL=NN SUFFIX="-nn" ./build.sh
