all: build run

# get:
# 	go get -u github.com/docker/docker/client || true
# 	go get -u github.com/docker/docker/api/container || true

build:
	go mod init greport.com/m/v2 || true
	go mod tidy
	go build -o scanner
	
run:
	./scanner

clean:
	rm -f scanner

fclean: clean
	rm -rf ./logs
