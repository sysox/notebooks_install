# Simple Jupyter Notebook launcher

The scripts create a local `.venv`, install everything in `requirements.txt`,
and open Jupyter in the browser.

The first run installs packages. Later runs skip installation. If
`requirements.txt` changes, the scripts detect the change and install again.
If the base Python installation changes or is removed, the scripts rebuild
`.venv` automatically. If Jupyter still fails to start, delete `.venv` and run
the launcher again.

Python 3 must already be installed:

- macOS: [python.org](https://www.python.org/downloads/) or `brew install python`.
  Without either, the first run of `python3` asks to install Apple's Command
  Line Tools, which provide an older Python.
- Linux: [python.org](https://www.python.org/downloads/) or your package manager
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

If the script is not executable, run it with `bash start_jupyter.sh` instead.

On macOS, you can also double-click `start_jupyter.command` in Finder. It
opens Terminal and starts the classic Notebook. If macOS blocks it the first
time, right-click the file, choose **Open**, and confirm.

On Linux, run `start_jupyter.sh` from a terminal; double-clicking scripts
works differently in each desktop environment.

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

You can also double-click `start_jupyter.cmd` in Explorer. It starts the
classic Notebook and works even when PowerShell blocks local scripts. It
accepts the same arguments from `cmd` or PowerShell:

```powershell
.\start_jupyter.cmd .\notebooks\basic.ipynb lab
```

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

1. Add the Jupyter interfaces to its `requirements.txt`, next to the packages
   its notebooks need:

   ```text
   nbclassic
   jupyterlab
   ```

2. Add `.venv/` to its `.gitignore`.
3. Keep the macOS/Linux launchers executable in git, because copying on
   Windows or through some file managers drops that flag:

   ```bash
   git add --chmod=+x start_jupyter.sh start_jupyter.command
   ```

Do not copy `requirements.txt`, `notebooks/` or `tests/` from this repo; they
belong to the example.

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
