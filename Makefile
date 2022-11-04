VERSION=9.8.0
EDITION=-ee

build-image:
	docker build --no-cache --pull --build-arg version=${VERSION} --build-arg -edition=${EDITION} -t ontotext/graphdb:${VERSION}${EDITION} .

push:
	docker push ontotext/graphdb:${VERSION}${EDITION}

