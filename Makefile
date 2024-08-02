PYENV := $(shell command -v pyenv 2> /dev/null)

ifndef PYENV
BASE_PYTHON ?= python3.9
else
BASE_PYTHON ?= pyenv exec python
endif

GCLOUD_LOGIN_ARGS ?=
PLATFORM_PARAM = --platform linux/amd64

ENV ?= venv
PROJECT_ID ?= gdg-x-gccd-extended-event

.PHONY: install
install: .install
.install: requirements.txt
	[ ! -d "$(ENV)/" ] && $(BASE_PYTHON) -m venv $(ENV)/ || :
	$(ENV)/bin/pip install --no-cache-dir --upgrade pip setuptools wheel
	$(ENV)/bin/pip install -r requirements.txt
	touch $@

.PHONY: run
run:
	$(ENV)/bin/python src/app.py

.PHONY: gcr-login
gcr-login:
	gcloud auth login $(GCLOUD_LOGIN_ARGS)
	gcloud config set project $(PROJECT_ID)
	gcloud auth configure-docker

.PHONY: docker-build
docker-build:
	docker build -t flask-gcp-docker $(PLATFORM_PARAM) .

.PHONY: docker-run
docker-run:
	docker run -p 8080:8080 flask-gcp-docker

.PHONY: docker-push
docker-push: gcr-login docker-build
	docker tag flask-gcp-docker gcr.io/$(PROJECT_ID)/flask-gcp-docker
	docker push gcr.io/$(PROJECT_ID)/flask-gcp-docker
