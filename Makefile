NAME = evenco/fake-sqs
VERSION = 0.2.0
IMAGE = $(NAME):$(VERSION)

all: build

clean:
	@CID=$(shell docker ps -a | awk '{ print $$1 " " $$2 }' | grep $(NAME) | awk '{ print $$1 }'); if [ ! -z "$$CID" ]; then echo "Removing container which reference $(NAME)"; for container in $(CID); do docker rm -f $$container; done; fi;
	@if docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then docker rmi -f $(NAME):$(VERSION); fi
	@if docker images $(NAME) | awk '{ print $$2 }' | grep -q -F latest; then docker rmi -f $(NAME):latest; fi

build:
	docker build -t $(IMAGE) --rm .

rebuild: clean
	docker build --no-cache -t $(IMAGE)

tag_latest:
	docker tag $(IMAGE) $(NAME):latest

debug:
	docker run -t -i --rm  $(IMAGE) /bin/bash -l
