% Script to develop and debug vecCostFunction.m, which
% generalises the neural network cost function and finds the gradients
% of the neural network for a multi-layer network.

% Load dataset:
%load( '2Dspheredata1.mat' );
load( '2Dclusterdata1.mat' );

% Vectorise variables
n_units = [ 2 , 3 , 5 , 6 , 4 ];
n_layers = size( n_units , 2 );

% Load initial theta matrices:
%load( 'initvals.mat' );

for d = 1:( n_layers-1)
  Thetas{ d } = randInitializeWeights( n_units( d ) , n_units( d+1 ) );
end
%initial_Theta1 = randInitializeWeights( ndim , nhiddenunits );
%initial_Theta2 = randInitializeWeights( nhiddenunits , nclasses );

% (NB) Show structure of the neural network from initial weights:            
featuresInit = showNetwork( Thetas );
title( "Neural network structure: initial random weights" , "FontSize" ,
      14 );

% Unroll parameters                                         
initial_nn_params = [];
for d = 1:( n_layers-1 )
  initial_nn_params = [ initial_nn_params ; Thetas{ d }(:) ];
end

%initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

% Set training parameters:
NumIter = 300;
options = optimset( 'MaxIter' , NumIter );
lambda = 0.1;


% Create "short hand" for the cost function to be minimized                  
costFunction = @(p) vecCostFunction( p , ...
                                   n_units , X , y , lambda );

% (NB) Run optimisation with fmincg, collect returned weights at quartiles   
[ nn_params, cost, it, qweights ] = fmincgv( costFunction , ...
                                   initial_nn_params , options );



% Reshape nn_params back into a cell array of Theta weight matrices:       
idx_start = 0;
for d = 1:( n_layers - 1 )

  idx_end = idx_start + n_units( d + 1 ) * ( n_units( d ) + 1 );

  Thetas{ d } = reshape( nn_params( idx_start + 1 : idx_end ), ...
                        n_units( d + 1 ), ...
                        n_units( d ) + 1 );
  idx_start = idx_end;
end


% Last output lines of training procedure with saved intial weights and
% single hidden layer of 6 units should be:

%Iteration     4 | Cost: 2.238821e+00
%Saving weights at snapshot 1.
%Iteration    10 | Cost: 1.925433e+00
%Saving weights at snapshot 2.
%Iteration    25 | Cost: 1.502466e+00
%Saving weights at snapshot 3.
%Iteration    50 | Cost: 1.399532e+00


% (NB) Show structure of the neural network with final learned weights:      
featuresFinal = showNetwork( Thetas , 2.5 );
title( "Neural network structure: final learned weights" , "FontSize" ,
      14 );










