% Script to develop and debug vecCostFunction.m, which
% generalises the neural network cost function and finds the gradients
% of the neural network for a multi-layer network.

% Load 2D spherical dataset:
load( '2Dspheredata1.mat' );

% Set initial parameters:
ndim = 2;
nhiddenunits = 8;
nclasses = 4;

% Load initial theta matrices:
load( 'initvals.mat' );

Thetas{ 1 } = initial_Theta1;
Thetas{ 2 } = initial_Theta2;

% (NB) Show structure of the neural network from initial weights:            
featuresInit = showNetwork( Thetas );
title( "Neural network structure: initial random weights" , "FontSize" ,
      14 );

% Unroll parameters                                         
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

% Set training parameters:
NumIter = 50;
options = optimset( 'MaxIter' , NumIter );
lambda = 0.1;


% Vectorise variables
n_units = [ ndim , nhiddenunits , nclasses ];


% Create "short hand" for the cost function to be minimized                  
costFunction = @(p) vecCostFunction( p , ...
                                   n_units , X , y , lambda );

% (NB) Run optimisation with fmincg, collect returned weights at quartiles   
[ nn_params, cost, it, qweights ] = fmincgv( costFunction , ...
                                   initial_nn_params , options );

% Obtain Theta1 and Theta2 back from nn_params                               
Theta1 = reshape( nn_params( 1 : nhiddenunits * ( ndim + 1 ) ) , ...
                 nhiddenunits , ( ndim + 1 ) );

Theta2 = reshape( nn_params( ( 1 + ...
         	      ( nhiddenunits * ( ndim + 1 ) ) ) : end ), ...
                  nclasses , ( nhiddenunits + 1 ) );


% Last output lines of training procedure should be: 

% J = 1.3945   49 | Cost: 1.402201e+00
% J = 1.4006
% J = 1.3934
% J = 1.3995
% Iteration    50 | Cost: 1.399532e+00


% (NB) Show structure of the neural network with final learned weights:      
Thetas{ 1 } = Theta1;
Thetas{ 2 } = Theta2;
featuresFinal = showNetwork( Thetas , 2.5 );
title( "Neural network structure: final learned weights" , "FontSize" ,
      14 );










