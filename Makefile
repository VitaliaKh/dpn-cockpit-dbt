PROJECT_NAME_DASHES := dpn-cockpit-dbt
ECR_PPD_URL := 614303399241.dkr.ecr.eu-west-1.amazonaws.com
ECR_PRD_URL := 585305677161.dkr.ecr.eu-west-1.amazonaws.com
VERSION := $(shell grep '^version:' dbt_project.yml | awk '{print $$2}' | sed "s/'//g")
DOCKER_IMAGE_DEV = $(PROJECT_NAME_DASHES):$(VERSION)
DOCKER_IMAGE = $(PROJECT_NAME_DASHES):$(VERSION)
THIS_DIR = $(shell pwd)

git-setup:
	git init
	git add .
	git commit -m "core: initial commit, instantiate project from template"
	git branch -M main
	git remote add origin git@github.com:VitaliaKh/dpn-cockpit-dbt.git
	git push -u origin main

import-packages:
	dbt deps

run:
	dbt run --profiles-dir $(THIS_DIR) --exclude example.*

run-example:
	dbt seed --profiles-dir $(THIS_DIR) --select example.*
	dbt run --profiles-dir $(THIS_DIR) --select example.*

run-tests:
	echo 'Faking tests...'

build-docker-image:
	docker build -t $(DOCKER_IMAGE) .

login-ecr-ppd:
	aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin $(ECR_PPD_URL)

upload-python-script-to-s3-on-dev:
	aws s3 rm s3://dev-dct-wksp-dps-dbt-training/z13vkhok/dbt/main.py
	aws s3 cp $(THIS_DIR)/main.py s3://dev-dct-wksp-dps-dbt-training/z13vkhok/dbt/main.py

publish-ecr-dev:
	docker tag $(DOCKER_IMAGE_DEV) $(ECR_PPD_URL)/$(DOCKER_IMAGE_DEV)
	docker push $(ECR_PPD_URL)/$(DOCKER_IMAGE_DEV)

upload-python-script-to-s3-on-ppd:
	aws s3 rm s3://ppd-dct-wksp-dps-dbt-training/z13vkhok/dbt/main.py
	aws s3 cp $(THIS_DIR)/main.py s3://ppd-dct-wksp-dps-dbt-training/z13vkhok/dbt/main.py

publish-ecr-ppd:
	docker tag $(DOCKER_IMAGE) $(ECR_PPD_URL)/$(DOCKER_IMAGE)
	docker push $(ECR_PPD_URL)/$(DOCKER_IMAGE)

login-ecr-prd:
	aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin $(ECR_PRD_URL)

upload-python-script-to-s3-on-prd:
	aws s3 rm s3://prd-dct-wksp-dpn/dbt/main.py
	aws s3 cp $(THIS_DIR)/main.py s3://prd-dct-wksp-dpn/dbt/main.py

publish-ecr-prd:
	docker tag $(DOCKER_IMAGE) $(ECR_PRD_URL)/$(DOCKER_IMAGE)
	docker push $(ECR_PRD_URL)/$(DOCKER_IMAGE)

run-dpn:
	dbt run --profiles-dir $(THIS_DIR) --select dpn.*