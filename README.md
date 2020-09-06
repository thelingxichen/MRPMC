
# MRPMC: Mortality Risk Prediction Model for COVID-19

MRPMC: Mortality Risk Prediction Model for COVID-19


## Pre-requirements
* R3.6
* caret
* e1071
* gbm
* randomForest


## Installation

### Installation from Github
To clone the repository and install manually, run the following from a terminal:
```Bash
git clone https://github.com/paprikachan/MRPMC.git
cd MRPMC
```

## Usage

### Help page

In command line:
```shell
Usage: Rscript server/predict_MRPMC.R [options]

Options:
        -i CHARACTER, --infile=CHARACTER
                Path of X input file

        -o CHARACTER, --outfile=CHARACTER
                Path of Y output file

        -h, --help
                Show this help message and exit
```

### Quick start
The following code runs an example of MRPMC.

```shell
server/predict_MRPMC.R -i test_X.csv -o pred_y.csv
```

## File format

### Input file


Input file is a csv file, stores the measurements of 14 lab test features for each patient:
* Age
* RR
* SpO2
* ALB
* BUN
* LBC
* PLT
* D-Dimer
* Gender
* Fever
* Sputum
* Consciousness
* CKD
* No. comorbidities


### Output file
Out file is a csv file, stores the predicted results from CIRPMC:
* LR: The predicted critical illness probablity from logistic regression
* SVM: The predicted critical illness probablity from supported vector machine
* KNN: The predicted critical illness probablity from k-nearest neighbor
* RF: The predicted critical illness probablity from random forest
* GBDT: The predicted critical illness probablity from gradient boosted decision tree
* NN: The predicted critical illness probablity from neural network
* Probability: The predicted critical illness probablity from our ensemble model CIRPMC
* Cluster: The predicted critical illness status, 0 or 1.
* Risk group: The stratified risk group, Non-critical or Critical.

## Cite us

## Help
If you have any questions or require assistance using MRPMC, please open an issue.
