pb:
	  go get -u github.com/golang/protobuf/protoc-gen-go
		@echo "pb Start"
asset:
	bash gen_assets.sh download
	mkdir assets
	cp -v data/*.dat assets/
	# cd assets;curl https://raw.githubusercontent.com/2dust/AndroidLibV2rayLite/master/data/geosite.dat > geosite.dat		
	# cd assets;curl https://raw.githubusercontent.com/2dust/AndroidLibV2rayLite/master/data/geoip.dat > geoip.dat

fetchDep:
	go get -v golang.org/x/mobile/cmd/...
	mkdir -p $(shell go env GOPATH)/src/github.com/XTLS/Xray-core/core
	git clone https://github.com/XTLS/Xray-core.git $(shell go env GOPATH)/src/v2ray.com/core
	go get -d github.com/eroxs/AndroidLibXraylite

ANDROID_HOME=$(HOME)/android-sdk-linux
export ANDROID_HOME
PATH:=$(PATH):$(GOPATH)/bin
export PATH
downloadGoMobile:
	cd ~ ;curl -L https://raw.githubusercontent.com/eroxs/AndroidLibXrayLite/master/ubuntu-cli-install-android-sdk.sh | sudo bash -
	ls ~
	ls ~/android-sdk-linux/

BuildMobile:
	gomobile init
	gomobile bind -v -ldflags='-s -w' github.com/eroxs/AndroidLibXraylite

all: asset pb fetchDep
	@echo DONE
