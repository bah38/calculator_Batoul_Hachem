"""Build, test and package the Lab 6 calculator."""

from pybuilder.core import Author, init, use_plugin

use_plugin("python.core")
use_plugin("python.unittest")
use_plugin("python.install_dependencies")
use_plugin("python.distutils")

name = "calculator_Batoul_Hachem"
version = "0.1"
default_task = "publish"
summary = "Lab 6 calculator by Batoul Hachem"
authors = [Author("Batoul Hachem", "")]
license = "Educational use"


@init
def initialize(project):
    project.set_property("dir_source_main_python", "src/main/python")
    project.set_property(
        "dir_source_unittest_python", "tests/unittest/calculator_Batoul_Hachem"
    )
    project.set_property("unittest_module_glob", "test_*")
    project.set_property("dir_target", "target")
    project.set_property("distutils_readme_description", True)
    project.set_property("distutils_description_overwrite", True)
