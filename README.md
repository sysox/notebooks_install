# Simple Jupyter launcher

## Quick start

Install Python 3 first:

- macOS: [python.org](https://www.python.org/downloads/) or `brew install python`
- Linux: use your package manager
- Windows: install Python with the `py` launcher enabled; the script calls `py -3`

On macOS, do not rely on the older Python offered through Command Line Tools;
install a current Python from python.org or Homebrew.

On Debian/Ubuntu, you may also need:

```bash
sudo apt install python3-venv
```

### macOS/Linux

```bash
./start_jupyter.sh
```

If the executable permission is lost, run `chmod +x start_jupyter.sh`, or use
`bash start_jupyter.sh`. Linux double-click behavior depends on the desktop
environment.

### Windows PowerShell

```powershell
.\start_jupyter.ps1
```

The default interface is the classic Notebook. The first run creates `.venv`
and installs `requirements.txt`; later runs start Jupyter directly. The browser
opens automatically. Stop Jupyter with `Ctrl+C`.

Put notebooks in this repository, for example in `notebooks/`. Add packages
needed by your notebooks to `requirements.txt`.

## Open a notebook

Pass a notebook path as the first argument:

```bash
./start_jupyter.sh notebooks/basic.ipynb
```

```powershell
.\start_jupyter.ps1 .\notebooks\basic.ipynb
```

Paths are resolved from the folder where the command is run.

## Use JupyterLab

JupyterLab is optional and is never selected by default. Pass `lab` explicitly:

```bash
./start_jupyter.sh notebooks/basic.ipynb lab
./start_jupyter.sh lab
```

```powershell
.\start_jupyter.ps1 .\notebooks\basic.ipynb lab
.\start_jupyter.ps1 lab
```

The argument format is:

```text
[notebook] [classic|lab]
```

When a notebook is supplied, Jupyter uses that notebook's folder in the file
browser. Without one, it uses this project folder.

## Windows and macOS shortcuts

On Windows, double-click `start_jupyter.cmd`. It works even when PowerShell
blocks local scripts. It can also receive the same arguments:

```powershell
.\start_jupyter.cmd .\notebooks\basic.ipynb lab
```

On macOS, double-click `start_jupyter.command`. If macOS blocks it, right-click
the file, choose **Open**, and confirm.

## Tests

The example notebook is tested with `nbclient`.

macOS/Linux:

```bash
.venv/bin/python -m pytest
```

Windows:

```powershell
.venv\Scripts\python.exe -m pytest
```

## Use in another repository

Copy the four launchers and `.gitattributes` into the other repository:

```text
start_jupyter.sh
start_jupyter.command
start_jupyter.ps1
start_jupyter.cmd
.gitattributes
```

Do not copy this repository's `requirements.txt`, `notebooks/`, or `tests/`;
they belong to this example. Add `nbclassic` and `jupyterlab` to the other
repository's existing `requirements.txt`, and add `.venv/` to its `.gitignore`.

Keep the Unix launchers executable in Git:

```bash
git add --chmod=+x start_jupyter.sh start_jupyter.command
```

If the other repository already has a `.gitattributes`, add the `*.cmd text
eol=crlf` line to it instead of replacing the file.

The launchers must sit next to that repository's `requirements.txt`; notebooks
can be anywhere.

## Recovery

The launchers rebuild `.venv` when its Python is missing or no longer runs. If
that does not fix a Python installation change, delete `.venv` and run the
launcher again. Changes to `requirements.txt` are detected automatically.
