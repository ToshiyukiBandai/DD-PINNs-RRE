# DD-PINNs-RRE: Physics-informed neural networks with Domain Decomposition for solving the Richardson-Richards equation

This repository contains Python source codes for physics-informed neural networks (PINNs) with domain decomposition (DD) for solving the Richardson-Richards equation (RRE), which can be used to simulate water flow in soils. Also, this repository contains the analytical solutions to verify the PINN solutions as well as finite difference (written in Matlab) and finite element methods (using HYDRUS-1D) for the comparison.

### Contents
* [xxx](#how-to-run)
* [xxx](#homogeneous)
* [xxx](#heterogeneous)

## how-to-run
DD-PINNs-RRE is written in Python with Tensorflow 1.15. Although you can run the Jupyter notebooks in your local machine, the easiest way to run the the Jupyter notebooks in the repository on [Google Colab](https://colab.research.google.com/). Select "File" and then choose the notebooks in your PC by clicking "Open notebook". Because the default Tensorflow on Google Colab is Tensorflow 2, you need to uninstall it and install Tensorflow 1.15 by running the codes below:

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

## homogeneous



## heterogeneous

## Citing DD-PINNs-RRE
To cite this repository:
"""
Bibtex
"""


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
