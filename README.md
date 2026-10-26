# Lab 6 - Calculator

Batoul Hachem

A Python calculator with addition, subtraction, multiplication, division,
modulus, power, and square root. Division and modulus reject a zero divisor;
square root rejects negative inputs.

## Setup and tests

Use Python 3.10 or later. From the project folder:

```sh
python -m pip install -r requirements.txt
pyb run_unit_tests
```

There are 21 unit tests covering the operations and error cases. To run them
without PyBuilder:

```sh
python -m unittest tests.unittest.calculator_Batoul_Hachem.test_calculator_Batoul_Hachem -v
```

## Build

```sh
pyb publish
```

This runs the tests and creates a source archive and wheel under `target/dist/`.
Running `pyb` alone uses the same default task.

## Makefile

GNU Make is needed for these commands:

| Command | Task |
| --- | --- |
| `make install` | Install the build tool. |
| `make clean` | Remove generated build files. |
| `make test` | Run unit tests. |
| `make build` | Test and package the calculator. |
| `make all` | Clean, install, test, and build. |

## Report and screenshots

- [Lab report](submission/Lab6_Report_Batoul_Hachem.pdf)
- [All screenshots in one PDF](screenshots/screenshots.pdf)
- [Screenshot images](screenshots/)
