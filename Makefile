.PHONY: dependencies format lint unit-test

SOURCE_DIR := src
TEST_DIR := tests

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
