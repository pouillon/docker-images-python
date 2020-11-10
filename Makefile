#
# Makefile for the Docker images to produce documentation on Debian
#

hypermodern_srcs = \
  hypermodern/Dockerfile \
  hypermodern/app-constraints.txt \
  hypermodern/app-requirements.txt \
  hypermodern/hypermodern-constraints.txt \
  hypermodern/hypermodern-env.sh \
  hypermodern/hypermodern-requirements.txt \
  hypermodern/install-app-env.sh \
  hypermodern/install-hypermodern-env.sh \
  hypermodern/packages-python.txt \
  hypermodern/packages-system.txt

hypermodern_tag = pouillon/python:hypermodern-focal-$(shell date '+%Y%m%d')

DEBUG ?= 0
ifeq ($(DEBUG),1)
  docker_opts = --progress=plain
else
  docker_opts = --progress=auto
endif

# Only give instructions to the user by default
all all_targets default: hypermodern-image

hypermodern-image: $(hypermodern_srcs)
	cd hypermodern && \
	  DOCKER_BUILDKIT=1 \
	  docker build $(docker_opts) --tag $(hypermodern_tag) .

upload: hypermodern-image
	docker push $(hypermodern_tag)

clean:
	@echo "Nothing to do."

.PHONY: all all_targets clean default hypermodern-image upload
