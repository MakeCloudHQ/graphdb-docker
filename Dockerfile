FROM eclipse-temurin:11-jdk-jammy

# Build time arguments
ARG version=9.8.0
ARG edition=-ee

ENV GRAPHDB_PARENT_DIR=/opt/graphdb
ENV GRAPHDB_HOME=${GRAPHDB_PARENT_DIR}/home

ENV GRAPHDB_INSTALL_DIR=${GRAPHDB_PARENT_DIR}/dist

WORKDIR /tmp

RUN apt-get update && apt-get install -y bash curl util-linux procps net-tools wget less unzip && \
    curl -fsSL "https://maven.ontotext.com/repository/owlim-releases/com/ontotext/graphdb/graphdb${edition}/${version}/graphdb${edition}-${version}-dist.zip" > \
    graphdb-${version}.zip && \
    bash -c 'md5sum -c - <<<"$(curl -fsSL https://maven.ontotext.com/repository/owlim-releases/com/ontotext/graphdb/graphdb${edition}/${version}/graphdb${edition}-${version}-dist.zip.md5)  graphdb-${version}.zip"' && \
    mkdir -p ${GRAPHDB_PARENT_DIR} && \
    cd ${GRAPHDB_PARENT_DIR} && \
    unzip /tmp/graphdb-${version}.zip && \
    rm /tmp/graphdb-${version}.zip && \
    mv graphdb${edition}-${version} dist && \
    mkdir -p ${GRAPHDB_HOME} && \
    ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

ENV PATH=${GRAPHDB_INSTALL_DIR}/bin:$PATH

CMD ["-Dgraphdb.home=/opt/graphdb/home"]

ENTRYPOINT ["/opt/graphdb/dist/bin/graphdb"]

EXPOSE 7200
EXPOSE 7300
