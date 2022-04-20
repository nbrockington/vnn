%% VNN1 -- Visualising how a toy neural network learns and classifies
%% data (proof of concept exercise)
%
% - This code is an edited version of the code from Coursera's 
%%  Machine Learning Online Class - Exercise 4 Neural Network Learning
% - This code also calls other scripts andfunctions written by the
% course instructions. 
%
%
% - VNN1 runs a small neural network on some loaded data. 
% - The training data are visualised as a 2D or 3D plot. 
% - The program then trains the neural network using backpropagation with
% gradient descent. 
% - The program then testsn the neural network on a different test
% dataset taken from the same parameters. A visualisation of test
% accuracy is plotted in 2D or 3D, with crosses showing locations of incorrect
% classifications in the input space. 
%
% KNOWN BUGS: Figure background colour must be changed from black to
% white by hand to navigate 3D plots.
%
%  ** IMPORTANT **
%  ** Original neural network code was written by the instructors of the
%  Coursera Machine Learning course by Andrew Ng. I have merely extended
%  this code to handle variable data and parameter dimensions, and added
%  visualisations.**
%  
%  Edited by Nela Brockington, 18th April 2022, London, U.K.



%% --------Initialization----------------------------------------
clc;
                    

% Identify Training Data
fprintf('Loading and Visualizing Data ...\n')

% load( '2Dclusterdata1.mat' );
% load('clusterdata1.mat');

load( '2Dspheredata1.mat' ); 
% load('spheredata1.mat');
% load('spheredata2.mat');
% load('spheredata3.mat');
m = size(X, 1);

% Display data
ndim = size( X , 2 );
if (ndim == 2)
  visualisedata2D( X , y );
else
  visualisedata( X , y );
end
title( "Training Dataset" , "FontSize" , 18 );

fprintf('\nProgram paused. Press enter to set initial random weights.\n');
pause;

%% INITIALISE NEURAL NETWORK STRUCTURE
fprintf( '\nInitialising Neural Network Structure ...\n' );

%% Number of units in each of the  layers of the neural network
% NB. Number of units in first layer is number of dimensions of data, ndim.
nhiddenunits = 25; 
nclasses = size( unique( y ) , 1 ); % Set to the number of labels


%% RANDOM INITIALISATION OF WEIGHTS %%
fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights( ndim , nhiddenunits );
initial_Theta2 = randInitializeWeights( nhiddenunits , nclasses );


% Unroll parameters                                                                      
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];


% Visualise the neural network output from the initial weights
if (ndim == 2)
  D = visualiseNNoutput( initial_Theta1 , initial_Theta2 );
  title( "Neural network output: initial random weights" ,
	"FontSize" , 18 );
end


fprintf('\nProgram paused. Press enter to train the neural network.\n');
pause;

%% --------------------------------------------------------------------
%% TRAINING THE NEURAL NETWORK %% 
fprintf('\nTraining Neural Network... \n')

% Setting up options for optimisation
options = optimset( 'MaxIter', 250 );

% Regularisation parameter
lambda = 0.1;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction( p , ...
                                   ndim , ...
                                   nhiddenunits , ...
                                   nclasses , X , y , lambda );

% Run optimisation with fmincg
[ nn_params, cost ] = fmincgwfigs( costFunction , initial_nn_params , options );

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape( nn_params( 1 : nhiddenunits * ( ndim + 1 ) ) , ...
                 nhiddenunits , ( ndim + 1 ) );

Theta2 = reshape( nn_params( ( 1 + ( nhiddenunits * ( ndim + 1 ) ) ) : end ) , ...
                 nclasses , ( nhiddenunits + 1 ) );

fprintf('\nProgram paused. Press enter to test the neural network.\n');
pause;

%% ---------------------------------------------------------------------------
%% TESTING THE NEURAL NETWORK %%

% Calculate training dataset error: 
pred_train = predict(Theta1, Theta2, X);
fprintf( "\nTraining Set Accuracy: %f\n" , mean(double(pred_train==y)) * 100);

% Visualise training set errors: 
if (ndim == 2)
  visualiseerror2D( X , y , pred_train );
else  
  visualiseerror( X , y , pred_train );
end
title( "Training Dataset: cross indicates classification error" ,
      "FontSize" , 18 );


% Calculate test dataset error (generalisation):
pred_test = predict(Theta1, Theta2, Xtest);
fprintf( "\nTest Set Accuracy: %f\n" , mean(double(pred_test==ytest)) * 100);

% Visualise test set errors:
if (ndim == 2 )
  visualiseerror2D( Xtest , ytest , pred_test );
else
  visualiseerror( Xtest , ytest , pred_test ); 
end
title( "Test Dataset: cross indicates classification error" ,
      "FontSize" , 18 );


% Visualise neural network outputs over the input space
if (ndim == 2)
  D = visualiseNNoutput( Theta1 , Theta2 );
  title( "Neural network output: final learned weights" ,
	"FontSize" , 18 );
endif



