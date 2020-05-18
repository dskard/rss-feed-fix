DOCKER_IMAGE_NAME=dskard/rss-feed-fix
WORKDIR=/tmp/work

all:

clean:
	rm -f lebatard.rss

distclean: clean
	rm -f version.txt

version:
	$(eval VERSION:=$(shell ./version.sh | tee ./version.txt))
	echo "VERSION=$(VERSION)"

docker-build: version
	docker build --tag ${DOCKER_IMAGE_NAME}:${VERSION} .

docker-run: version
	docker run --init --rm \
	    --name rss-feed-fix \
	    --user `id -u`:`id -g` \
	    --volume ${CURDIR}:${WORKDIR} \
	    --workdir ${WORKDIR} \
	    ${DOCKER_IMAGE_NAME}:${VERSION}

.PHONY: all
.PHONY: clean
.PHONY: distclean
.PHONY: docker-build
.PHONY: docker-run
.PHONY: version
