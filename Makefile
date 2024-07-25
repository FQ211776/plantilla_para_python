# The binary to build (just the basename).
MODULE := blueprint


BLUE='\033[0;34m'
NC='\033[0m' # No Color

run:
	@python -m $(MODULE)

test:
	@pytest

clean:
	rm -rf .pytest_cache .coverage .pytest_cache coverage.xml
