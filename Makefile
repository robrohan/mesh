clean:
	go clean -i
	rm -rf doco
	rm -rf dist

test:
	cd algebra; go test
	cd geometry; go test
	cd render; go test

build: clean
	mkdir dist
	go build -o dist/mesh
	cp -R assets dist/assets

deps:
	# SDL 2
	brew install sdl2{,_image,_mixer,_ttf,_gfx} pkg-config
	# SDL Bindings
	# go get -v github.com/veandco/go-sdl2/sdl
	# go get -v github.com/veandco/go-sdl2/img
	# go get -v github.com/veandco/go-sdl2/mix
	# go get -v github.com/veandco/go-sdl2/ttf
	# go get -v github.com/veandco/go-sdl2/gfx
	go get -v github.com/veandco/go-sdl2/{sdl,img,mix,ttf}
	# OpenGL
	go get -u github.com/go-gl/gl/v{3.2,3.3,4.1,4.2,4.3,4.4,4.5,4.6}-{core,compatibility}/gl
	# OpenGL ES is not supported on macos (only ios)
	# go get -u github.com/go-gl/gl/v3.1/gles2
	go get -u github.com/go-gl/gl/v2.1/gl
	go get -v github.com/chsc/gogl/gl33

install:
	go install

docs:
	mkdir doco
	godoc -html ./algebra > ./doco/algebra.html
	godoc -html ./geometry > ./doco/geometry.html
	godoc -html ./render > ./doco/render.html
