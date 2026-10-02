.DEFAULT_GOAL := all

all: build sign

clean:
	@rm -rf app/build/
	@rm -rf build/

build: clean
	@./gradlew build
	@cp app/build/outputs/apk/release/app-release-unsigned.apk ./build/

sign:
	@~/Library/Android/sdk/build-tools/34.0.0/zipalign -v 4 build/app-release-unsigned.apk build/app-release-aligned.apk
	@~/Library/Android/sdk/build-tools/34.0.0/apksigner sign --ks my-release-key.jks --out build/red-moon.apk build/app-release-aligned.apk
	@cp build/red-moon.apk ~/Downloads/red-moon-4.1.0.apk