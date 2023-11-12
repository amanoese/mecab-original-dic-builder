IMAGE_NAME ?= "mecab-original-dic-builder"

.PHONY: all build dist

all: build dist

build:
	docker build -t $(IMAGE_NAME) .

dist:
	docker create $(IMAGE_NAME) | xargs -I@ sh -c '\
		docker cp @:/app/add_cost.csv ./dist ;\
		docker cp @:/app/original.dic ./dist ;\
		docker rm @\
	'

