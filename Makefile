PYTHON ?= python
PYB ?= pyb

.DEFAULT_GOAL := all
.PHONY: all clean install install_deps test build package
# Keep the clean/test/package sequence safe even with make -j.
.NOTPARALLEL:

install: install_deps

install_deps:
	$(PYTHON) -m pip install -r requirements.txt

clean:
	$(PYB) clean

test:
	$(PYB) run_unit_tests

build: package

package:
	$(PYB) publish

all: clean install_deps test build
