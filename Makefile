.PHONY: dependencies format lint unit-test local-infra clean

SOURCE_DIR := src
TEST_DIR := tests
INFRA_DIR := infra/terraform

dependencies:
	pip install -q -U pip virtualenv
	virtualenv -q venv
	. venv/bin/activate
	pip install -q -U isort black flake8 pytest coverage coverage-badge
	pip install -q -r requirements.txt
	pip install -q -r $(TEST_DIR)/requirements.txt

format:
	isort $(SOURCE_DIR) $(TEST_DIR)
	black $(SOURCE_DIR) $(TEST_DIR)

lint: format
	flake8 $(SOURCE_DIR) $(TEST_DIR)

unit-test:
	coverage run --source=$(SOURCE_DIR) -m pytest $(TEST_DIR)/unit
	coverage report -m
	coverage-badge -q -f -o coverage.svg

local-infra:
	docker compose -f localstack.yml up -d
	pip install -q -U -r requirements.txt -t dep
	cd dep && zip -q -r ../lambda.zip ../src . && cd .. && rm -rf dep
	terraform -chdir=$(INFRA_DIR) init && terraform -chdir=$(INFRA_DIR) apply --auto-approve

clean:
	cd $(INFRA_DIR) && terraform destroy -auto-approve && rm -rf .terraform* terraform.* && cd ../..
	docker compose -f localstack.yml down
	-rm -rf dep lambda.zip
