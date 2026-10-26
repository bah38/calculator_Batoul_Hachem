"""Allow direct unittest commands to import the source-layout package."""

from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "src/main/python"))
