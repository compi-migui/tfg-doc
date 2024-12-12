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
The code used in this work is freely available in the GitHub repository found at the following address: [https://github.com/compi-migui/shmowt](https://github.com/compi-migui/shmowt). It is written in the Python programming language, and uses all free and open-source software (FOSS) libraries, which means anyone can take it, run it, modify it and distribute it without having to pay for costly licenses or even ask for permission.

That repository is by far the best way to view the source code. However, to guard against the obsolescence of a third party service, its contents are also included in this appendix with files grouped by their function.

## Documentation

### README.md
The project is briefly introduced and documented by a _README.md_, in markdown format. It states its purpose and gives instructions to install and execute it.

\small
``````markdown {.numberLines}
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
\normalsize

## Configuration

### config.ini
A _config.ini_ file allows providing the path to the data file to be processed, the path where joblib's disk cache will be stored and also allows setting verbosity flags to ease debugging.

\small
```ini {.numberLines}
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
\normalsize

## Packaging and dependency management
The project's packaging and dependencies are managed using the [Poetry tool](https://python-poetry.org/docs/). There are two files that describe them.

### pyproject.toml
_pyproject.toml_ contains some project metadata and the top-level dependencies (libraries the project imports directly).

\small
```ini {.numberLines}
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
\normalsize

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
The actual source code of the project is split into three files: _config.py_, _data.py_ and _main.py_.

### config.py
_config.py_ contains the configuration loader function that allows extracting parameters set in the _config.ini_ file.

\small
```python {.numberLines}
import configparser
from pathlib import Path


def get_config(config_path=None):
    if not config_path:
        config_path = Path.home() / 'shmowt' / 'contrib' / 'config.ini'
    config = configparser.ConfigParser()
    config.read(config_path)
    return config
```
\normalsize

### data.py
_data.py_ contains the function that extract the data to be processed from a file, truncate the samples as described in [@Sec:results-data}] and add class labels (the data set provided to the author does not include label metadata, but the samples were sorted by class).

\small
```python {.numberLines}
from pathlib import Path

import h5py
import pandas as pd


def load_raw_data(data_path):
    with h5py.File(data_path, 'r') as data_file:
        data_all = data_file['datacompleto']
        data = _truncate_data(data_all)
    # noinspection PyTypeChecker
    data.insert(0, 'class', [class_mapper(i) for i in range(data.shape[0])])
    return data


def _truncate_data(data_all):
    # Keep only the first 403 samples in each trial.
    # Works around the fact we're using a data set with too large trials.
    columns = 58008  # row leng
    L = 2417  # samples per sensor per trial
    keep = 403  # how many samples per sensor per trial to actually keep
    keep_columns = [i for i in range(columns) if i % L < keep]
    data = pd.DataFrame(data_all[keep_columns,]).transpose()
    return data


def class_mapper(n):
    # Our dataset doesn't have metadata for what class each experiment belongs to,
    # so work it out from the order they're provided in.
    classes = [0, 1, 2, 3, 4]
    if n < 2460:
        return classes[0] # healthy
    elif 2460 <= n < 2460 + 820:
        return classes[1]
    elif 2460 + 820 <= n < 2460 + 820*2:
        return classes[2]
    elif 2460 + 820*2 <= n < 2460 + 820*3:
        return classes[3]
    elif 2460 + 820*3 <= n < 2460 + 820*4:
        return classes[4]
```
\normalsize

### main.py
_main.py_ includes the bulk of the data processing, performance measurement and the generation of all plots and tables included in this document.

\small
```python {.numberLines}
import os
from pathlib import Path
import tempfile

from joblib import Memory
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.decomposition import PCA
from sklearn.metrics import confusion_matrix, matthews_corrcoef, ConfusionMatrixDisplay
from sklearn.model_selection import KFold
from sklearn.neighbors import KNeighborsClassifier
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import FunctionTransformer, StandardScaler
from sklearn.svm import SVC


from shmowt.config import get_config
from shmowt.data import load_raw_data

config = get_config(os.getenv('SHMOWT_CONFIG'))
cache_path = config.get('cache', 'path', fallback=None)
if cache_path is None:
    cache_path = Path(tempfile.gettempdir()) / 'shmowt-cache'
    cache_path.mkdir(exist_ok=True)
memory = Memory(cache_path, verbose=config.get('debug', 'verbose_memory', fallback=0))


def accuracy(tn, fp, fn, tp):
    return (tp+tn)/(tp+fp+fn+tn)


def precision(tn, fp, fn, tp):
    return tp/(tp+fp)


def sensitivity(tn, fp, fn, tp):
    # aka recall
    return tp/(tp+fn)


def f1_score(ppv, tpr):
    return 2*(ppv*tpr)/(ppv+tpr)


def specificity(tn, fp, fn, tp):
    return tn/(tn+fp)


def upm(tn, fp, fn, tp):
    # Unified Performance Measure
    # https://doi.org/10.1007/978-3-030-62365-4_10
    return 4*tp*tn/(4*tp*tn + (tp+tn)*(fp+fn))


def gps_upm(upm_list):
    # General Performance Score
    # https://doi.org/10.1007/s10489-021-03041-7
    classes = len(upm_list)
    nominator = classes*np.prod(upm_list)
    denominator = 0
    for k_prime in range(classes):
        where = [True]*classes
        where[k_prime] = False  # Exclude k=k_prime case from product
        denominator = denominator + np.prod(upm_list, where=where)
    return nominator/denominator


def metrics_from_confusion_matrix(conf_matrix):
    metrics = {'acc': [], 'ppv': [], 'tpr': [], 'f1': [], 'tnr': [], 'upm': []}
    for cls in range(len(conf_matrix)):
        total = conf_matrix.sum()  # numpy.ndarray.sum
        predicted_positives = sum(conf_matrix[:, cls])
        predicted_negatives = total - predicted_positives
        tp = conf_matrix[cls][cls]
        fp = predicted_positives - tp
        fn = sum(conf_matrix[cls]) - tp
        tn = predicted_negatives - fn
        metrics['acc'].append(accuracy(tn, fp, fn, tp))
        metrics['ppv'].append(precision(tn, fp, fn, tp))
        metrics['tpr'].append(sensitivity(tn, fp, fn, tp))
        metrics['tnr'].append(specificity(tn, fp, fn, tp))
        metrics['upm'].append(upm(tn, fp, fn, tp))
    for metric in metrics:
        if metric == 'upm':
            continue
        metrics[metric] = np.mean(metrics[metric])
    metrics['f1'] = f1_score(metrics['ppv'], metrics['tpr'])
    metrics['gps_upm'] = gps_upm(metrics['upm'])
    return metrics


def noop_core(X):
    return X


def noop():
    """
    Used to trick sklearn into caching the final transformer in a pipeline.
    See https://github.com/scikit-learn/scikit-learn/issues/23112
    """
    return FunctionTransformer(noop_core)


def reproduce_paper(data_path, memory, verbose_pipelines=False):
    """
    This procedure applies column scaling and dimensionality reduction to the entire dataset, and only applies
    cross-validation to the classifier. Same as the paper does.
    :param data_path:
    :param memory:
    :param verbose_pipelines:
    :return:
    """
    # Table 5 in the paper
    results = {"knn": [], "svm": []}
    kfold_splits = 5
    results["knn"] = pd.DataFrame(columns=['variance', 'pc_num', 'k', 'acc', 'ppv', 'tpr', 'f1', 'tnr'])
    results["svm"] = pd.DataFrame(columns=['variance', 'pc_num', 'ρ', 'acc', 'ppv', 'tpr', 'f1', 'tnr'])

    explained_variances = [0.85, 0.90, 0.95]
    k = [1, 5, 10, 25, 50, 100, 150, 200, 250, 300, 500]
    kernel_scale = [5, 20, 30, 40, 50, 60, 70, 80, 90, 100, 150, 200, 300]

    for variance in explained_variances:
        # Adding back the class label makes the data consistent with the not-overfit case, avoiding special case
        # handling.
        results_tmp = []
        raw_results_tmp = []
        for neighbors in k:
            # Only save PCA plots once, they're identical across runs
            save_pca_plots = (variance == 0.9 and k == 1)
            params = {'variance': variance, 'kfold_splits': kfold_splits, 'k': neighbors}

            raw_results, params = run_overfit_pipeline(pipeline_name='knn', data_path=data_path, params=params)
            eval_indicators, conf_matrices = compute_performance_metrics(raw_results)

            new_row = pd.Series(params | eval_indicators | {'conf_matrices': conf_matrices})
            # As recommended in official pandas docs https://pandas.pydata.org/docs/reference/api/pandas.concat.html
            # "It is not recommended to build DataFrames by adding single rows in a for loop.
            # Build a list of rows and make a DataFrame in a single concat."
            results_tmp.append(new_row)

        concat_me = [results["knn"]]
        concat_me.extend([new_row.to_frame().T for new_row in results_tmp])
        results["knn"] = pd.concat(concat_me, ignore_index=True)
        save_indicators_plot(results=results["knn"].loc[results["knn"]['variance'] == variance],
                             method="knn",
                             param_column='k',
                             prefix="reproduce")

        results_tmp = []
        for r in kernel_scale:
            params = {'variance': variance, 'kfold_splits': kfold_splits, 'ρ': r}
            raw_results, params = run_overfit_pipeline(pipeline_name='svm', data_path=data_path, params=params)
            eval_indicators, conf_matrices = compute_performance_metrics(raw_results)
            new_row = pd.Series(params | eval_indicators | {'conf_matrices': conf_matrices})
            results_tmp.append(new_row)
        concat_me = [results["svm"]]
        concat_me.extend([new_row.to_frame().T for new_row in results_tmp])
        results["svm"] = pd.concat(concat_me, ignore_index=True)
        save_indicators_plot(results=results["svm"].loc[results["svm"]['variance'] == variance],
                             method="svm",
                             param_column='ρ',
                             prefix="reproduce")

    return results


@memory.cache
def run_overfit_pipeline(pipeline_name, data_path, params, save_pca_plot=False, verbose=False):
    pipeline_overfit = Pipeline(
        [
            ('column_scaling', StandardScaler()),
            ('dim_reduction', PCA(svd_solver='full', n_components=params['variance'])),
            ('classification', noop())
        ],
        memory=memory,
        verbose=verbose
    )
    pipeline_overfit.set_output(transform='pandas')
    data_raw = load_raw_data(data_path)
    data = pipeline_overfit.fit_transform(data_raw.loc[:, data_raw.columns.drop("class")])
    data.insert(0, 'class', data_raw.loc[:, 'class'])
    params['pc_num'] = pipeline_overfit.named_steps['dim_reduction'].n_components_
    if save_pca_plot:
        save_pca_scatter_plots(pca_data=data, prefix='reproduce')

    if pipeline_name == 'knn':
        pipeline = overfit_pipeline_knn(data=data, k=params['k'], verbose=verbose)
    elif pipeline_name == 'svm':
        pipeline = overfit_pipeline_svm(data=data, r=params['ρ'], verbose=verbose)
    else:
        raise ValueError(f"Unkown pipeline name: {pipeline_name}")

    raw_results = cross_validation(data=data, pipeline=pipeline, kfold_splits=params['kfold_splits'])
    return raw_results, params


def overfit_pipeline_knn(data, k, verbose=False):
    pipeline = Pipeline(
        [
            ('classification', KNeighborsClassifier(n_neighbors=k))
        ],
        memory=memory,
        verbose=verbose
    )
    return pipeline


def overfit_pipeline_svm(data, r, verbose=False):
    pipeline = Pipeline(
        [
            ('classification', SVC(C=1.0, kernel='poly', degree=2, coef0=0, gamma=1/(r**2)))
        ],
        memory=memory,
        verbose=verbose
    )
    return pipeline


def reproduce_noleak(data_path, memory, verbose_pipelines=False):
    """
    This procedure applies strict train/test separation across the entire pipeline.
    """
    # Table 5 in the paper
    results = {"knn": [], "svm": []}
    kfold_splits = 5
    results["knn"] = pd.DataFrame(columns=['variance', 'pc_num', 'k', 'acc', 'ppv', 'tpr', 'f1', 'tnr'])
    results["svm"] = pd.DataFrame(columns=['variance', 'pc_num', 'ρ', 'acc', 'ppv', 'tpr', 'f1', 'tnr'])

    explained_variances = [0.85, 0.90, 0.95]
    k = [1, 5, 10, 25, 50, 100, 150, 200, 250, 300, 500]
    kernel_scale = [5, 20, 30, 40, 50, 60, 70, 80, 90, 100, 150, 200, 300]

    for variance in explained_variances:
        # Adding back the class label makes the data consistent with the not-overfit case, avoiding special case
        # handling.
        results_tmp = []
        for neighbors in k:
            params = {'variance': variance, 'kfold_splits': kfold_splits, 'k': neighbors}

            raw_results, params = run_noleak_pipeline(pipeline_name='knn', data_path=data_path, params=params)
            eval_indicators, conf_matrices = compute_performance_metrics(raw_results)

            new_row = pd.Series(params | eval_indicators | {'conf_matrices': conf_matrices})
            # As recommended in official pandas docs https://pandas.pydata.org/docs/reference/api/pandas.concat.html
            # "It is not recommended to build DataFrames by adding single rows in a for loop.
            # Build a list of rows and make a DataFrame in a single concat."
            results_tmp.append(new_row)

        concat_me = [results["knn"]]
        concat_me.extend([new_row.to_frame().T for new_row in results_tmp])
        results["knn"] = pd.concat(concat_me, ignore_index=True)
        save_indicators_plot(results=results["knn"].loc[results["knn"]['variance'] == variance],
                             method="knn",
                             param_column='k',
                             prefix="noleak")

        results_tmp = []
        for r in kernel_scale:
            params = {'variance': variance, 'kfold_splits': kfold_splits, 'ρ': r}
            raw_results, params = run_noleak_pipeline(pipeline_name='svm', data_path=data_path, params=params)
            eval_indicators, conf_matrices = compute_performance_metrics(raw_results)
            new_row = pd.Series(params | eval_indicators | {'conf_matrices': conf_matrices})
            results_tmp.append(new_row)
        concat_me = [results["svm"]]
        concat_me.extend([new_row.to_frame().T for new_row in results_tmp])
        results["svm"] = pd.concat(concat_me, ignore_index=True)
        save_indicators_plot(results=results["svm"].loc[results["svm"]['variance'] == variance],
                             method="svm",
                             param_column='ρ',
                             prefix="noleak")

    return results


@memory.cache
def run_noleak_pipeline(pipeline_name, data_path, params, save_pca_plot=False, verbose=False):
    data = load_raw_data(data_path)

    if pipeline_name == 'knn':
        pipeline = Pipeline(
            [
                ('column_scaling', StandardScaler()),
                ('dim_reduction', PCA(svd_solver='full', n_components=params['variance'])),
                ('classification', KNeighborsClassifier(n_neighbors=params['k']))
            ],
            memory=memory,
            verbose=verbose
        )
    elif pipeline_name == 'svm':
        pipeline = Pipeline(
            [
                ('column_scaling', StandardScaler()),
                ('dim_reduction', PCA(svd_solver='full', n_components=params['variance'])),
                ('classification', SVC(C=1.0, kernel='poly', degree=2, coef0=0, gamma=1/(params['ρ']**2)))
            ],
            memory=memory,
            verbose=verbose
        )
    else:
        raise ValueError(f"Unkown pipeline name: {pipeline_name}")

    # pipeline.set_output(transform='pandas')
    raw_results = cross_validation(data=data, pipeline=pipeline, kfold_splits=params['kfold_splits'])
    # Different splits will end up with different numbers of principal components. Report the truncated average for
    # a reasonable comparison point.
    params['pc_num'] = int(np.mean([raw_results[i]['pc_num'] for i, _ in enumerate(raw_results)]))
    return raw_results, params


def save_pca_scatter_plots(pca_data, prefix=''):
    """
    Create and save scatter plots of PCA data
    :param pca_data: Array-like of data that already went through PCA
    :param prefix: string prepended to the saved figure filename
    :return:
    """
    for component_pair in [(0, 1), (0, 2), (0, 13), (0, 24)]:
        save_pca_scatter_plot(pca_data=pca_data, component_pair=component_pair, prefix=prefix)


def save_pca_scatter_plot(pca_data, component_pair, prefix=''):
    """
    Create a single scatter plot of Xth vs Yth principal component
    :param pca_data: Array-like of data that already went through PCA
    :param component_pair: tuple of two ints, the principal components to plot. 0 is the first principal component
    :param prefix: string prepended to the saved figure filename
    :return:
    """
    #
    fig, ax = plt.subplots(figsize=(6, 4),
                           layout='constrained',
                           frameon=False,  # No background color
                           )
    color_mapping = zip(['blue', 'purple', 'red', 'olive', 'lime'], [0, 1, 2, 3, 4])
    for color, dataset in color_mapping:
        ax.scatter(
            pca_data.loc[pca_data['class'] == dataset, f"pca{component_pair[0]}"],
            pca_data.loc[pca_data['class'] == dataset, f"pca{component_pair[1]}"],
            s=5,
            color=color,
            alpha=0.8,
            label=dataset
        )
    ax.set_xlabel(f"Principal component {component_pair[0]+1}")  # 0 is the 1st principal component and so on
    ax.set_ylabel(f"Principal component {component_pair[1]+1}")
    ax.grid(True)
    save_path = (Path(config.get('out', 'path'))
                 / f"{prefix}-pca-plot-{component_pair[0]+1}-vs-{component_pair[1]+1}.png")
    fig.savefig(save_path,
                format='png',
                transparent=False,
                dpi=200,
                bbox_inches='tight')


def save_indicators_plot(results, method, param_column, prefix=''):
    """
    Figures 10 and 11 in the Sensors paper
    """
    variance = results.iloc[0].at['variance']  # We assume the dataset was pre-selected
    fig, ax = plt.subplots(figsize=(6, 4),
                           layout='constrained',
                           frameon=False,  # No background color
                           )

    variants = results[param_column].unique()
    names = ["acc", "ppv", "tpr", "f1", "tnr", "mcc", "gps_upm"]
    for variant in variants:
        # Tansform dataframe so that pyplot is happy with its shape
        ax.plot(names,
                results.loc[results[param_column] == variant, names].iloc[0],
                marker='.',
                label=f"{param_column}={int(variant)}")

    # TODO: add legend
    save_path = (Path(config.get('out', 'path'))
                 / f"{prefix}-indicators-plot-{method}-var{variance}.png")
    ax.grid(True)
    ax.legend()
    fig.savefig(save_path,
                format='png',
                transparent=False,
                dpi=200,
                bbox_inches='tight')


def save_confusion_matrices(results, prefix=''):
    """
    Figures 10 and 11 in the Sensors paper
    """
    # Let's plot only the confusion matrix for the first K-fold split
    save_dir = Path(config.get('out', 'path'))
    for classifier in results:
        if classifier == 'knn':
            name = 'k-NN'
            param = 'k'
        elif classifier == 'svm':
            name = 'SVM'
            param = 'ρ'
        else:
            raise ValueError(f"Unkown classifier name: {classifier}")
        for variance in results[classifier]['variance'].unique():
            for i, _ in enumerate(results[classifier].iloc[0]['conf_matrices']):
                save_path = save_dir / Path(f"{prefix}-conf_matrices-{classifier}-var{variance}-{i}.png")
                subset = results[classifier].loc[results[classifier]['variance'] == variance].iloc[:12]
                fig, axs = plt.subplots(4,
                                        3,
                                        figsize=(8, 12),
                                        layout='constrained',
                                        frameon=False,  # No background color
                                        )
                ax_index = 0
                for idx, row in subset.iterrows():
                    cmd = ConfusionMatrixDisplay(row['conf_matrices'][i])
                    cmd.plot(cmap='Blues', colorbar=False, ax=axs.flat[ax_index])
                    axs.flat[ax_index].set_title(f"{param}={row[param]}")
                    ax_index += 1
                for ax in axs.flat:
                    if not bool(ax.has_data()):
                        fig.delaxes(ax)
                fig.savefig(save_path,
                            format='png',
                            transparent=False,
                            dpi=100,
                            bbox_inches='tight')


def save_classifier_tables(results, prefix=''):
    """
    :param results: dict of DataFrames. keys are classifier names
    :param prefix: string prepended to the saved figure filename
    :return:
    """
    save_dir = Path(config.get('out', 'path'))

    column_map = {
        'variance': '\\thead{Explained\\\\ variance}',
        'pc_num': '\\thead{Number\\\\ of PCs}',
        'k': '\\thead{Neighbors\\\\ ($k$)}',
        'ρ': '\\thead{Kernel scale\\\\ ($\\rho$)}',
        'acc': '\\thead{Accuracy\\\\ ($\\overline{\\text{acc}}$)}',
        'ppv': '\\thead{Precision\\\\ ($\\overline{\\text{ppv}}$)}',
        'tpr': '\\thead{Sensitivity\\\\ ($\\overline{\\text{tpr}}$)}',
        'f1': ' \\thead{F\\textsubscript{1}‐measure}',
        'tnr': '\\thead{Specificity \\\\($\\overline{\\text{tnr}}$)}',
        'gps_upm': '\\thead{GPS}',
        'mcc': '\\thead{MCC}'
    }

    for classifier in results:
        # 00% for explained variance, 0.0000% for all other floats (performance indicators)
        floatfmt = ['.0%', 'g', 'g']
        floatfmt.extend(['.2%'] * results[classifier].shape[1])
        save_path = save_dir / Path(f"{prefix}-results-table-{classifier}.md")
        printable = results[classifier].rename(columns=column_map)
        # UPM is an array which gets cumbersome. Exclude it since gps_upm kinda includes that info
        printable.drop(columns=['upm', 'conf_matrices', 'kfold_splits']).to_markdown(
                                                                               buf=save_path,
                                                                               mode='wt',
                                                                               index=False,
                                                                               tablefmt='latex_raw',
                                                                               floatfmt=floatfmt,
                                                                               numalign=None,
                                                                               stralign=None)


@memory.cache
def cross_validation(data, pipeline, kfold_splits):
    """
    Runs pipeline fit and prediction with K-Fold splits.
    :param data: Input data.
    :param pipeline: The pipeline to fit and predict with.
    :param kfold_splits: How many different train/test splits to do.
    :return: List of true and predicted categories for each kfold split.
    """
    raw_results = []
    # Unlike the paper, this pipeline uses holdouts and cross-validation for the entire process, including scaling
    # and dimensionality reduction. Putting it aside for now for the sake of 100% reproduction of the paper's
    # results.
    # TODO: Come back to this later.
    kfold_splits = 5
    kf = KFold(n_splits=kfold_splits, shuffle=True, random_state=0)
    for train, test in kf.split(data):
        pipeline.fit(data.loc[train, data.columns.drop("class")], data.loc[train, 'class'])
        # pipeline.fit(data_pca[train], data_raw.loc[train, 'class'])

        predicted = pipeline.predict(data.loc[test, data.columns.drop("class")])
        # predicted = pipeline.predict(data_pca[test])
        true = data.loc[test, 'class']
        raw_results.append({'true': true,
                            'predicted': predicted,
                            'pc_num': pipeline.named_steps['dim_reduction'].n_components_})
    return raw_results


def compute_performance_metrics(raw_results):
    if isinstance(raw_results, list):
        metrics = {}
        split_metrics = []
        for split in raw_results:
            split_metrics.append(compute_performance_metrics(split))
        for metric in split_metrics[0][0]:
            # Evaluator indicators are averaged from the indicators of all splits
            if isinstance(split_metrics[0][0][metric], list):
                # If the original metric is an array, we must average each element in a slice across splits
                metrics[metric] = []
                for i, _ in enumerate(split_metrics[0][0][metric]):
                    metrics[metric].append(np.mean([x[0][metric][i] for x in split_metrics]))
            else:
                metrics[metric] = sum([x[0][metric] for x in split_metrics]) / len(split_metrics)
        conf_matrices = [x[1] for x in split_metrics]
        return metrics, conf_matrices
    conf_matrix = confusion_matrix(raw_results['true'], raw_results['predicted'])
    metrics = metrics_from_confusion_matrix(conf_matrix)
    metrics['mcc'] = matthews_corrcoef(raw_results['true'], raw_results['predicted'])
    return metrics, conf_matrix


def main():
    data_path = config.get('data', 'path')

    eval_indicators = reproduce_paper(data_path,
                                      memory,
                                      config.getboolean('debug', 'verbose_pipelines', fallback=False))
    save_classifier_tables(eval_indicators, prefix='reproduce')
    save_confusion_matrices(eval_indicators, prefix='reproduce')

    eval_indicators_noleak = reproduce_noleak(data_path,
                                              memory,
                                              config.getboolean('debug', 'verbose_pipelines', fallback=False))
    save_classifier_tables(eval_indicators_noleak, prefix='noleak')
    save_confusion_matrices(eval_indicators_noleak, prefix='noleak')


if __name__ == '__main__':
    main()
```
\normalsize
