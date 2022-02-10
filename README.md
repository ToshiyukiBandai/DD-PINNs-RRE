# DD-PINNs-RRE: Physics-informed neural networks with Domain Decomposition for solving the Richardson-Richards equation

This repository contains Python source codes for physics-informed neural networks (PINNs) with domain decomposition (DD) for solving the Richardson-Richards equation (RRE), which can be used to simulate water flow in soils. Also, this repository contains the analytical solutions to verify the PINN solutions as well as finite difference (written in Matlab) and finite element methods (using HYDRUS-1D) for comparison. The results are summarized in a paper that is currently under reviewed.

### Contents
* [PINNs_codes](#PINNs_codes)
* [FDM_codes](#FDM_codes)
* [analytical solution](#analytical-solution)
* [results](#results)
* [Citing DD-PINNs-RRE](#Citing-DD-PINNs-RRE)
* [License](#License)

## PINNs_codes
The directory "PINNs_codes" contains Jupyter notebooks to run DD-PINNs-RRE as well as data files in the "data" sub-directory for three cases (two forward modelings and one inverse modeling). DD-PINNs-RRE is written in Python with Tensorflow 1.15. Although you can run the Jupyter notebooks in your local machine, the easiest way to run the Jupyter notebooks in the repository on [Google Colab](https://colab.research.google.com/). First, select "File" and then choose the notebooks on your PC by clicking "Open notebook." Because the default Tensorflow on Google Colab is Tensorflow 2, you need to uninstall it and install Tensorflow 1.15 by running the codes below:

```python
%tensorflow_version 2.x
!pip uninstall -y tensorflow
!pip install tensorflow-gpu==1.15.0
```

To import data (training data and interface points), you need to allow Google Colab to have access to Google Drive by running
"""
from google.colab import drive
drive.mount("/content/drive")
cd drive/My\ Drive # change the directory if necessary
"""
You need to place the directories for the analytical solution and the data for training (residual points for both cases and interface points for the heterogeneous case) accordingly (please refer to the structure of this repository).

## FDM_codes
This directory contains Matlab codes to solve the RRE using a finite difference method for a homogeneous soil.

## analytical solution
The directory "analytical solutions" contain the analytical solutions to the RRE by Srivastava and Yeh (1991). The analytical solutions are saved as .npy files to be used later to verify DD-PINNs-RRE. The Jupyter notebooks are also available to obtain the analytical solutions for different hydraulic parameters. For heterogeneous soils, the procedures to obtain the analytical solutions depend on hydraulic parameters. Please refer to the Jupyter notebook and the original paper for detail.

```
@article{Srivastava1991,
author = {Srivastava, R. and Yeh, T. C. J.},
doi = {10.1029/90WR02772},
journal = {Water Resources Research},
number = {5},
pages = {753--762},
title = {{Analytical solutions for one-dimensional, transient infiltration toward the water table in homogeneous and layered soils}},
volume = {27},
year = {1991}
}
```

This directory contains numerical solutions by  [HYDRUS-1D](https://www.pc-progress.com/en/Default.aspx?hydrus-1d) used for inverse modeling to estimate surface water flux (true solution and noisy data). The HYDRUS output files are located in "results/inverse/HYDRUS." Note that the performance of PINNs is strongly affected by the initialization of neural networks, as dicsused in the paper. If you cannot obtain good results, please try different random seeds for the initialization.

## results
This directory contains results shown in the paper.

### forward_homogeneous
The sub-directory "forward_homogeneous" contains results for the forward modeling of a homogeneous soil (Section 3.1 in the paper).
* "best_case": Example of a PINNs simulation
* "FDM": Finite difference simulations
* "training": PINNs simulations to demonstrate the evolution of loss terms and activation function parameters, whereby different IDs show simulations with different random seeds (ID=2 is shown in the paper)
* "trainng_evolution": PINNs simulations to demonstrate how PINNs learn the solution
* "adaptive_residual.xls": Results for the residual-based adaptive refinement algorithm
* "adaptive_weights.xls": Results for the adaptive learning rate algorithm
* "collocation_points.xls": Results for the effects of the number of residual points
* "NN_architecture.csv": Results for the effects of the architecture of neural networks
* "upper_boundary.xls": Results for the effects of the number of upper boundary data points
* "weight_parameters.xls": Results for the effects of weight parameters in the loss function

### forward_heterogeneous
The sub-directory "forward_heterogeneous" contains results for the forward modeling of a two-layered heterogeneous soil (Section 3.2 in the paper).
* "best_case": Example of a PINNs simulation
* "HYDRUS": Output files of the HYDRUS-1D simulation with initial condition (psi_ini.csv) and lookup table (look_up.xlsx)  
* "training": PINNs simulations to demonstrate the evolution of loss terms and activation function parameters, whereby different IDs show simulations with different random seeds
* "trainng_evolution": PINNs simulations to demonstrate how PINNs learn the solution
* "collocation_points.xls": Results for the effects of the number of interface points
* "weight_parameters.xls": Results for the effects of weight parameters in the loss function

### inverse
The sub-directory "inverse" contains results for the inverse modeling of a two-layered heterogeneous soil (Section 4 in the paper).
* "HYDRUS": Output files of the HYDRUS-1D simulation for the training data
* "VGM_noise": PINNs simulations with different measurement schemes and random seeds

### example-homogeneous
The sub-directory "example-homogeneous" contains the results of a PINN simulation obtained by running the Jupyter notebook for the homogeneous case.

### example-heterogeneous
The sub-directory "example-heterogeneous" contains the results of a PINN simulation obtained by running the Jupyter notebook for the heterogeneous case.

### example-inverse
The sub-directory "example-inverse" contains the results of a PINN simulation obtained by running the Jupyter notebook for the inverse modeling.

## Citing DD-PINNs-RRE
To cite the paper:

```
Hopefully coming!
```

To cite this repository:

```
@misc{Bandai2022,
author = {Bandai, T. and Ghezzehei, T. A.},
doi = {10.5281/zenodo.6030635},
publisher = {Dataset on Zenodo},
title = {{DD-PINNS-RRE}},
year = {2022}
}
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
