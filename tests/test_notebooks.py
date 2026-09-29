from pathlib import Path

import nbformat
from nbclient import NotebookClient


NOTEBOOK = Path(__file__).parents[1] / "notebooks" / "basic.ipynb"


def test_basic_notebook_runs():
    notebook = nbformat.read(NOTEBOOK, as_version=4)
    NotebookClient(notebook, timeout=60, kernel_name="python3").execute()

    output = notebook.cells[1].outputs[0]
    assert output["data"]["text/plain"].strip() == "6"
