% DEMBRENDAN3 Model the face data with a 2-D GPLVM.

% GPLVM

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

display = 0;

dataSetName = 'brendan';
experimentNo = 3;

% load data
[Y, lbls] = gplvmLoadData(dataSetName);

% Set IVM active set size and iteration numbers.
options = gplvmOptions;
numActive = 100;

% Initialise X with PCA
X = gplvmPcaInit(Y, 2);

% Fit the GP latent variable model
noiseType = 'gaussian';
kernelType = {'mlp', 'bias', 'white'};
model = gplvmFit(X, Y, numActive, options, noiseType, kernelType, lbls);

% Save the results.
X = model.X;  
[kern, noise, ivmInfo] = ivmDeconstruct(model);
capName = dataSetName;
capName(1) = upper(capName(1));
save(['dem' capName num2str(experimentNo) '.mat'], 'X', 'kern', 'noise', 'ivmInfo');

% Load the results and display dynamically.
gplvmResultsDynamic(dataSetName, experimentNo, 'image', [20 28], 1, 0, 1)

% Load the results and display statically.
% gplvmResultsStatic(dataSetName, experimentNo, 'image', [20 28], 1, 0, 1)

% Load the results and display as scatter plot
% gplvmResultsStatic(dataSetName, experimentNo, 'none')