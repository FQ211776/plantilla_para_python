# The binary to build (just the basename).
MODULE := blueprint
VENV := venv
REQUIREMENTS := requirements.txt


BLUE='\033[0;34m'
NC='\033[0m' # No Color

run:
	@$(VENV)/bin/python -m $(MODULE)

test:
	@$(VENV)/bin/pytest

clean:
	rm -rf .pytest_cache .coverage .pytest_cache coverage.xml

install: venv
	$(VENV)/bin/pip install -r $(REQUIREMENTS)

# Create virtual environment
venv:
	python3 -m venv $(VENV)
	@echo "Run 'source $(VENV)/bin/activate' to activate the virtual environment."

# delete venv
delete_venv:
	rm -rf $(VENV)

# Upgrade pip
upgrade_pip:
	$(VENV)/bin/pip install --upgrade pip
