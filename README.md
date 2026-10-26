# Lab 6 - Automatic Build

**Student:** Batoul Hachem  
**Project:** calculator_Batoul_Hachem

The calculator provides `add`, `subtract`, `multiply`, `divide`, `modulus`,
`power`, and `square_root`. Division and modulus reject zero divisors with
`ValueError`; square root rejects negative inputs. Modulus follows Python's
remainder convention (for example, `modulus(-10, 3)` returns `2`).

## Setup and required PyBuilder exercise

Use Python 3.10 or later. From this project directory:

```powershell
python -m pip install -r requirements.txt
pyb run_unit_tests
python -m unittest tests.unittest.calculator_Batoul_Hachem.test_calculator_Batoul_Hachem -v
pyb clean install_build_dependencies publish
```

The last command cleans previous build output, prepares build dependencies,
runs all 21 tests, and creates the source archive and wheel under
`target/dist/calculator_Batoul_Hachem-0.1/dist/`. Running `pyb` alone also
executes `publish`, the default task. PyBuilder manages its own build environment.
On this computer `pyb` uses Python 3.13, while `python` uses Python 3.10;
the unit tests are checked with both.

`unittest_module_glob` is explicitly set to `test_*`: PyBuilder's default
`*_tests` pattern would miss the lab's `test_...py` filenames and run zero tests.
The test suite covers all seven functions, zero/negative inputs, fractional
results, zero divisors, and invalid square-root inputs.

## Optional Makefile exercise

GNU Make must be installed and available on PATH. The Makefile delegates to
PyBuilder and uses commands that work on Windows and Unix:

| Command | Purpose |
| --- | --- |
| `make install` or `make install_deps` | Install the pinned build tool from requirements.txt. |
| `make clean` | Remove PyBuilder's generated target directory. |
| `make test` | Run the calculator unit tests through PyBuilder. |
| `make build` or `make package` | Test and create distributable archives with `pyb publish`. |
| `make all` or `make` | Clean, install dependencies, test, then package. |

Override tool commands if necessary, for example `make PYTHON="py -3.13" all`.
Named targets replace repeated commands with a consistent build process.
Phony targets always run; serial execution keeps clean before the build.
Build failures propagate to Make rather than reporting success.

## Submission evidence

- [All screenshots in one PDF](submission/Lab6_Screenshots_Batoul_Hachem.pdf)
- [Full lab report](submission/Lab6_Report_Batoul_Hachem.pdf)
- [Required PyBuilder screenshot](submission/pybuilder.png)
- [Detailed unit-test screenshot](submission/unittest.png)
- [Optional Makefile build screenshot](submission/make.png)
- [Project files and packages screenshot](submission/files.png)

See `submission/` for original command logs and the generated packages.
The required PyBuilder screenshot shows the project base directory, nonzero
test count, successful build, and elapsed time. Screenshots capture actual
command runs. The optional Makefile work is included in the same project.

## GitHub submission

Submit the GitHub repository URL to the professor. The repository contains the
source files, unit tests, `build.py`, `Makefile`, requirements, and the PDFs and
screenshots linked above. Build environments and caches are excluded by
`.gitignore`; they are recreated by PyBuilder.

The professor can clone the repository, enter its directory, and run the setup
and test commands above. On GitHub, open either PDF and use **Download raw file**
to download it. For a private repository, grant the professor access before
submitting its URL.
