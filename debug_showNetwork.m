% Script to develop and debug the showNetwork function

clear all; close all;

% Setting up the neural network
clc;
ndim = input( "Enter n dimensions of data: " );

n_hidden_layers = input( "Enter the number of hidden layers: " );
while n_hidden_layers < 1 || n_hidden_layers > 5
  fprintf( "No. of hidden layers should be between 1 and 5 inclusive.\n" );
  n_hidden_layers = input( "Enter the number of hidden layers: " );
end

list_units = [ ndim ];

for i = 2:( n_hidden_layers + 1 )
  fprintf( "\nSelect the number of units in layer %1i." , i );
  list_units( i ) = input( "\nEnter value here: " );
  while list_units( i ) < 1 || list_units( i ) > 20
    fprintf( "Number of units must be between 1 and 20 inclusive.\n" );
    list_units( i ) = input( "\nEnter value here: " );
  end
end

list_units( end+1 ) = input( "\nEnter no. of units in output layer: " )



% Randomly initializing weights of layer neural network:
Thetas{ 1 , n_hidden_layers + 1 } = [];

for d = 1:( n_hidden_layers + 1 )
  Thetas{ d } = randInitializeWeights( list_units( d ) , ...
				       list_units( d+1 ) );
end

% Th1 = randInitializeWeights( ndim , nhiddenunits );
% Th2 = randInitializeWeights( nhiddenunits , nclasses );

% Thetas{ 1 } = Th1;
% Thetas{ 2 } = Th2;

% Running showNetwork.m script:

features = showNetwork( Thetas );




