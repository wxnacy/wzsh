alias dgit="docker run --rm -e GIT_USERNAME=${GIT_USERNAME} -e GIT_EMAIL=${GIT_EMAIL} -e GIT_PASSWORD=${GIT_PASSWORD} -e RUN_MODEL=DEBUG -v $(pwd):/root/work wxnacy/git:1.0.0"
