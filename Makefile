build:
	./build.sh

start:
	./start.sh

clean:
	rm -rf termux-node-pty reh reh-web
	git submodule update --init
