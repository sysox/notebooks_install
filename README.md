# Simple Jupyter Notebook launcher

The scripts create a local `.venv`, install everything in `requirements.txt`,
and open Jupyter in the browser.

The first run installs packages. Later runs skip installation. If
`requirements.txt` changes, the scripts detect the change and install again.
If the base Python installation changes or is removed, delete `.venv` and run
the launcher again.

Python 3 must already be installed:

- macOS/Linux: [python.org](https://www.python.org/downloads/)
- Windows: install Python with the `py` launcher enabled
- Debian/Ubuntu: install the venv package if needed: `sudo apt install python3-venv`

## Arguments

The optional arguments are positional:

```text
[notebook] [classic|lab]
```

The default is `classic`. Running either script without arguments opens the
classic Notebook interface. Use `lab` explicitly for JupyterLab.

Notebook paths are resolved from the folder where the command is run. When a
notebook path is supplied, Jupyter opens that notebook and uses its folder for
the file browser. Without a notebook path, it uses this project folder.

## macOS/Linux

```bash
chmod +x start_jupyter.sh
./start_jupyter.sh
```

Open the example notebook:

```bash
./start_jupyter.sh notebooks/basic.ipynb
```

Use JupyterLab:

```bash
./start_jupyter.sh notebooks/basic.ipynb lab
```

Or open JupyterLab without selecting a notebook:

```bash
./start_jupyter.sh lab
```

## Windows

```powershell
.\start_jupyter.ps1
```

Open the example notebook:

```powershell
.\start_jupyter.ps1 .\notebooks\basic.ipynb
```

Use JupyterLab:

```powershell
.\start_jupyter.ps1 .\notebooks\basic.ipynb lab
```

Or open JupyterLab without selecting a notebook:

```powershell
.\start_jupyter.ps1 lab
```

If PowerShell blocks local scripts:

```powershell
powershell -ExecutionPolicy Bypass -File .\start_jupyter.ps1
```

## Tests

The example notebook is tested with `nbclient`:

macOS/Linux:

```bash
.venv/bin/python -m pytest
```

Windows:

```powershell
.venv\Scripts\python.exe -m pytest
```
