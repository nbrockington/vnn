% Script to develop and debug the showNetwork function

clear all; close all;

% Setting up units for a three-layer neural network: 
ndim = input( 'Enter n dimensions of data: ' );
nhiddenunits = input( 'Enter number of units in hidden layer: ' );
nclasses = input( 'Enter number of units in output layer: ' );


% Randomly initializing weights of three-layer neural network:
Th1 = randInitializeWeights( ndim , nhiddenunits );
Th2 = randInitializeWeights( nhiddenunits , nclasses );

Thetas{ 1 } = Th1;
Thetas{ 2 } = Th2;

% Running showNetwork.m script: 

figref = showNetwork( Thetas );



