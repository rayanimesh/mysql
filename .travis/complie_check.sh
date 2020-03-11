#!/bin/bash
set -e 
dist_list=$(go tool dist list)

for dist in ${dist_list}; do
    GOOS=$(echo ${dist} | cut  -d "/" -f 1)
    GOARCH=$(echo ${dist} | cut -d "/" -f 2)
    echo "Checking compile support for ${GOOS}/${GOARCH}"
    set +e
    GOOS=${GOOS} GOARCH=${GOARCH} go tool compile -V > /dev/null
    if [[ $? -ne 0 ]]; then
        echo "compile support for ${GOOS}/${GOARCH} is not provided; skipping"
        continue
    fi
    set -e
    echo "Building  ${GOOS}/${GOARCH}"
    GOOS=${GOOS} GOARCH=${GOARCH} go build  -o /dev/null
 done
