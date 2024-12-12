\clearpage
\appendix
\appendixtocon
\appendixtitleon
\appendixtitletocon
\appendixheaderon
\appendixpage

# Confusion matrices for all configurations {#sec:appendix-confusion-matrices}
This appendix includes confusion matrices with raw results for classifier configurations used throughout this work. Note that, because we used 5-fold cross-validation, there are actually five different confusion matrices for each configuration which were then used to compute separate performance metrics to be averaged together.

Including all five matrices for all configurations would bloat the size of this document for very questionable value, so only the first one out of five is presented.

## Confusion matrices for the original methodology (replication)
![Confusion matrices for the k-NN classifier using principal components that explain 85% of variance.](reproduce-conf_matrices-knn-var0.85-0.png){#fig:reproduce-conf_matrices-knn-var0.85-0 width=85%}

![Confusion matrices for the k-NN classifier using principal components that explain 90% of variance.](reproduce-conf_matrices-knn-var0.9-0.png){#fig:reproduce-conf_matrices-knn-var0.9-0 width=85%}

![Confusion matrices for the k-NN classifier using principal components that explain 95% of variance.](reproduce-conf_matrices-knn-var0.95-0.png){#fig:reproduce-conf_matrices-knn-var0.95-0 width=85%}

![Confusion matrices for the SVM classifier using principal components that explain 85% of variance.](reproduce-conf_matrices-svm-var0.85-0.png){#fig:reproduce-conf_matrices-svm-var0.85-0 width=85%}

![Confusion matrices for the SVM classifier using principal components that explain 90% of variance.](reproduce-conf_matrices-svm-var0.9-0.png){#fig:reproduce-conf_matrices-svm-var0.9-0 width=85%}

![Confusion matrices for the SVM classifier using principal components that explain 95% of variance.](reproduce-conf_matrices-svm-var0.95-0.png){#fig:reproduce-conf_matrices-svm-var0.95-0 width=85%}

## Confusion matrices for the new methodology (data leakage avoidance)
![Confusion matrices for the k-NN classifier using principal components that explain 85% of variance, with data leakage avoidance.](noleak-conf_matrices-knn-var0.85-0.png){#fig:noleak-conf_matrices-knn-var0.85-0 width=85%}

![Confusion matrices for the k-NN classifier using principal components that explain 90% of variance, with data leakage avoidance.](noleak-conf_matrices-knn-var0.9-0.png){#fig:noleak-conf_matrices-knn-var0.9-0 width=85%}

![Confusion matrices for the k-NN classifier using principal components that explain 95% of variance, with data leakage avoidance.](noleak-conf_matrices-knn-var0.95-0.png){#fig:noleak-conf_matrices-knn-var0.95-0 width=85%}

![Confusion matrices for the SVM classifier using principal components that explain 85% of variance, with data leakage avoidance.](noleak-conf_matrices-svm-var0.85-0.png){#fig:noleak-conf_matrices-svm-var0.85-0 width=85%}

![Confusion matrices for the SVM classifier using principal components that explain 90% of variance, with data leakage avoidance.](noleak-conf_matrices-svm-var0.9-0.png){#fig:noleak-conf_matrices-svm-var0.9-0 width=85%}

![Confusion matrices for the SVM classifier using principal components that explain 95% of variance, with data leakage avoidance.](noleak-conf_matrices-svm-var0.95-0.png){#fig:noleak-conf_matrices-svm-var0.95-0 width=85%}

# Source code
The code used in this work is freely available in the GitHub repository found at the following address: [https://github.com/compi-migui/shmowt]. It is written in the Python programming language, and uses all free and open-source software (FOSS) libraries, which means anyone can take it, run it, modify it and distribute it without having to pay for costly licenses or even ask for permission.

That repository is by far the best way to view the source code. However, to guard against the obsolescence of a third party service, its contents are also included in this appendix with files grouped by their function.

## Documentation

### README.md
The project is briefly introduced and documented by a _README.md_, in markdown format. It states its purpose and gives instructions to install and execute it.

``````markdown
# shmowt
Structural Health Monitoring for Jacket-Type Offshore Wind Turbines.

This project aims to replicate the methodology and results of the paper[1] [accessible here](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7180893/).

It also proposes a few improvements described in the companion report (unpublished).

[1] Vidal Y, Aquino G, Pozo F, Gutiérrez-Arias JEM. Structural Health Monitoring for Jacket-Type Offshore Wind Turbines: Experimental Proof of Concept. Sensors (Basel). 2020 Mar 26;20(7):1835. doi: 10.3390/s20071835. PMID: 32224918; PMCID: PMC7180893.

## Installation and usage
Dependencies are managed by [poetry](https://python-poetry.org/docs/#installation), so you must install that first.

Clone the repository:

```bash
git clone git@github.com:compi-migui/shmowt.git
cd shmowt
```
Install dependencies:

```bash
poetry install
```
Run shmowt:

```bash
SHMOWT_CONFIG=~/shmowt/contrib/config.ini poetry run
```
``````

## Configuration

### config.ini
A _config.ini_ file allows providing the path to the data file to be processed, the path where joblib's disk cache will be stored and also allows setting verbosity flags to ease debugging.

```
[data]
path = "/path/to/your_data.mat"
[cache]
path = ""
[out]
path = ""
[debug]
verbosity_memory = 0
verbose_pipelines = False
```

## Packaging and dependency management
The project's packaging and dependencies are managed using the [Poetry tool](https://python-poetry.org/docs/). There are two files that describe them.

### pyproject.toml
_pyproject.toml_ contains some project metadata and the top-level dependencies (libraries the project imports directly).

```
[tool.poetry]
name = "shmowt"
version = "0.1.0"
description = ""
authors = ["Miguel Garcia <dev@migarcia.cat>"]
readme = "README.md"
packages = [{include = "shmowt", from = "src"}]

[tool.poetry.dependencies]
python = ">=3.12,<3.13" # Imposed by river 0.21.0
scipy = "^1.11.4"
pandas = {version="^2.1.4", extras=["output-formatting"]}
matplotlib = "^3.8.2"
river = "^0.21.0"
scikit-learn = "^1.3.2"
h5py = "^3.11.0"
joblib = "^1.4.2"

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
```

### poetry.lock
_poetry.lock_ is a frozen snapshot of the exact version of all recursive dependencies (meaning, the project's direct dependencies, their dependencies and so on) to be installed. The use of this lockfile makes execution and reproduction possible even after years of version drift in dependencies of dependencies.

It is 933 lines long and contains over 97000 characters, so its contents are not included here. Instead, [@Tbl:poetry-installed-packages] lists all the installed dependencies, their exact versions and a short description as obtained by running the _poetry show_ command.

| Package         | Version     | Short description                                                             |
|-----------------|-------------|-------------------------------------------------------------------------------|
| contourpy       | 1.2.1       | Python library for calculating contours of 2D quadrilateral grids             |
| cycler          | 0.12.1      | Composable style cycles                                                       |
| fonttools       | 4.51.0      | Tools to manipulate font files                                                |
| h5py            | 3.11.0      | Read and write HDF5 files from Python                                         |
| jinja2          | 3.1.4       | A very fast and expressive template engine.                                   |
| joblib          | 1.4.2       | Lightweight pipelining with Python functions                                  |
| kiwisolver      | 1.4.5       | A fast implementation of the Cassowary constraint solver                      |
| markupsafe      | 3.0.2       | Safely add untrusted strings to HTML/XML markup.                              |
| matplotlib      | 3.9.0       | Python plotting package                                                       |
| numpy           | 1.26.4      | Fundamental package for array computing in Python                             |
| packaging       | 24          | Core utilities for Python packages                                            |
| pandas          | 2.2.2       | Powerful data structures for data analysis, time series, and statistics       |
| pillow          | 10.3.0      | Python Imaging Library (Fork)                                                 |
| polars          | 0.20.26     | Blazingly fast DataFrame library                                              |
| pyparsing       | 3.1.2       | pyparsing module - Classes and methods to define and execute parsing grammars |
| python-dateutil | 2.9.0.post0 | Extensions to the standard Python datetime module                             |
| pytz            | 2024.1      | World timezone definitions, modern and historical                             |
| river           | 0.21.1      | Online machine learning in Python                                             |
| scikit-learn    | 1.4.2       | A set of python modules for machine learning and data mining                  |
| scipy           | 1.13.0      | Fundamental algorithms for scientific computing in Python                     |
| six             | 1.16.0      | Python 2 and 3 compatibility utilities                                        |
| tabulate        | 0.9.0       | Pretty-print tabular data                                                     |
| threadpoolctl   | 3.5.0       | threadpoolctl                                                                 |
| tzdata          | 2024.1      | Provider of IANA time zone data                                               |

: Installed dependencies, their exact versions and a short description as obtained by running the _poetry show_ command {#tbl:poetry-installed-packages}

## Source code


