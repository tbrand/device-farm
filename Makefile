build:
	docker build -t device-farm .

run:
	docker run --privileged -it device-farm bash
