# Simple Jupyter Notebook launcher

The scripts create a local `.venv`, install everything in `requirements.txt`,
and open Jupyter in the browser. The first run installs packages; later runs
start Jupyter straight away.

Python 3 must already be installed:

- macOS: [python.org](https://www.python.org/downloads/) or `brew install python`
- Linux: [python.org](https://www.python.org/downloads/) or your package
  manager; on Debian/Ubuntu also `sudo apt install python3-venv`
- Windows: install Python with the `py` launcher enabled

## Usage

The optional arguments are positional:

```text
[notebook] [classic|lab]
```

The default is `classic`, the classic Notebook interface. Use `lab` for
JupyterLab. Notebook paths are resolved from the folder where the command is
run, and Jupyter's file browser opens in the notebook's folder (or in this
project folder when no notebook is given).

Stop Jupyter with Ctrl+C in the terminal where it runs.

### macOS/Linux

```bash
./start_jupyter.sh                            # classic Notebook
./start_jupyter.sh notebooks/basic.ipynb      # open a notebook
./start_jupyter.sh notebooks/basic.ipynb lab  # open a notebook in JupyterLab
./start_jupyter.sh lab                        # JupyterLab without a notebook
```

If you get "Permission denied", run `chmod +x start_jupyter.sh` once, or start
it with `bash start_jupyter.sh`.

On macOS, you can also double-click `start_jupyter.command` in Finder. If
macOS blocks it the first time, right-click the file, choose **Open**, and
confirm. On Linux, run the script from a terminal; double-clicking scripts
works differently in each desktop environment.

### Windows

```powershell
.\start_jupyter.ps1                              # classic Notebook
.\start_jupyter.ps1 .\notebooks\basic.ipynb      # open a notebook
.\start_jupyter.ps1 .\notebooks\basic.ipynb lab  # open a notebook in JupyterLab
.\start_jupyter.ps1 lab                          # JupyterLab without a notebook
```

`start_jupyter.cmd` accepts the same arguments and also works when PowerShell
blocks local scripts. You can double-click it in Explorer.

## Your notebooks and packages

Put notebooks in `notebooks/`. Add the packages they need to
`requirements.txt`; the launcher installs them on its next start.

## Use in another repo

Copy these files into the root of the other repo:

| File | Purpose |
|---|---|
| `start_jupyter.sh` | macOS/Linux launcher |
| `start_jupyter.command` | macOS double-click launcher |
| `start_jupyter.ps1` | Windows launcher |
| `start_jupyter.cmd` | Windows double-click launcher |
| `.gitattributes` | Keeps Windows line endings in `start_jupyter.cmd`; if the repo already has one, add its line instead |

Then, in the other repo:

1. Add `nbclassic` and `jupyterlab` to its `requirements.txt`, next to the
   packages its notebooks need.
2. Add `.venv/` to its `.gitignore`.
3. Keep the macOS/Linux launchers executable in git, because copying on
   Windows or through some file managers drops that flag:

   ```bash
   git add --chmod=+x start_jupyter.sh start_jupyter.command
   ```

Do not copy `requirements.txt`, `notebooks/` or `tests/` from this repo; they
belong to the example.

## Troubleshooting

- **Packages changed:** the launcher notices edits to `requirements.txt` and
  installs again.
- **Python upgraded or removed:** the launcher rebuilds `.venv` automatically.
- **Jupyter still fails to start:** delete `.venv` and run the launcher again.
- **macOS asks to install Command Line Tools:** no Python is installed yet.
  Install one of the Pythons above instead; the Command Line Tools provide an
  older one.
- **PowerShell blocks the script:** use `start_jupyter.cmd` instead.

## Tests

The example notebook is tested with `nbclient`:

```bash
.venv/bin/python -m pytest              # macOS/Linux
.venv\Scripts\python.exe -m pytest      # Windows
```
