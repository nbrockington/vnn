%% VNN -- Visualising how a toy neural network learns and classifies
%% data (proof of concept exercise)
%
% - This code is an edited version of the code from Coursera's 
%%  Machine Learning Online Class - Exercise 4 Neural Network Learning
% - This code also calls other scripts andfunctions written by the
% course instructors. 
%
%
% - VNN runs a small neural network on some loaded data. 
% - The training data are visualised as a 2D or 3D plot. 
% - The program then trains the neural network using backpropagation with
% gradient descent. 
% - The program then testsn the neural network on a different test
% dataset taken from the same parameters. A visualisation of test
% accuracy is plotted in 2D or 3D, with crosses showing locations of incorrect
% classifications in the input space. 
%
% %
%  ** IMPORTANT **
%  ** Original neural network code was written by the instructors of the
%  Coursera Machine Learning course by Andrew Ng. I have extended
%  this code to handle variable data and parameter dimensions, and added
%  visualisations.**
%  
%  Edited by Nela Brockington, June 2022, London, U.K.
%  Edits indicated by (NB) comments.


%% --------Initialization----------------------------------------
clc;
                    

% (NB) Identify Training Data
fprintf('Loading and Visualizing Data ...\n')

load( '2Dclusterdata1.mat' );
% load('clusterdata1.mat');

% load( '2Dspheredata1.mat' ); 
% load('spheredata1.mat');
% load('spheredata2.mat');
% load('spheredata3.mat');
m = size( X , 1 );


% (NB) Create Figure 1 to visualise: 
% - Training Data (subplot 1/4)
% - Initial random weights (subplot 2/4)
% - Performance on Training Data after training (subplot 3/4)
% - Performance on Test Data after training (subplot 4/4)
figure( 1 );
subplot( 2 , 2 , 1 );
hold on;

% (NB) Display training data visually
ndim = size( X , 2 );
if (ndim == 2)
  visualisedata2D( X , y );
else
  visualisedata( X , y );
end
title( "Training Set" , "FontSize" , 14 );
%close;


fprintf('\nProgram paused. Press enter to set initial random weights.\n');
%pause;

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


% (NB) Visualise the neural network output from the initial weights
if (ndim == 2)
  figure( 1 );
  subplot( 2 , 2 , 2 ); hold on;
  D = visualiseNNoutput( initial_Theta1 , initial_Theta2 );
  title( "Neural network: initial random weights" ,
	"FontSize" , 14 );
end
%close;

fprintf('\nProgram paused. Press enter to train the neural network.\n');
%pause;

%% --------------------------------------------------------------------
%% TRAINING THE NEURAL NETWORK %% 
fprintf('\nTraining Neural Network... \n')

% Setting up options for optimisation: number of iterations
NumIter = 20;
options = optimset( 'MaxIter', NumIter );

% Regularisation parameter
lambda = 0.1;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction( p , ...
                                   ndim , ...
                                   nhiddenunits , ...
                                   nclasses , X , y , lambda );

% (NB) Run optimisation with fmincg, collect returned weights at quartiles
[ nn_params, cost, it, qweights] = fmincgv( costFunction , ...
				   initial_nn_params , options );

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape( nn_params( 1 : nhiddenunits * ( ndim + 1 ) ) , ...
                 nhiddenunits , ( ndim + 1 ) );

Theta2 = reshape( nn_params( ( 1 + ( nhiddenunits * ( ndim + 1 ) ) ) : end ) , ...
                 nclasses , ( nhiddenunits + 1 ) );

%fprintf('\nProgram paused. Press enter to run the neural network on the test data.\n');
%pause;

%% ---------------------------------------------------------------------------
%% TESTING THE NEURAL NETWORK %%

% Calculate training dataset error: 
pred_train = predict(Theta1, Theta2, X);
fprintf( "\n** Training Set Accuracy: %.1f%% **\n" , ...
	mean(double(pred_train==y)) * 100 );

% (NB) Visualise training set errors onto Figure 1 subplot:
figure( 1 );
subplot( 2 , 2 , 3 ); hold on;
if (ndim == 2)
  visualiseerror2D( X , y , pred_train );
else  
  visualiseerror( X , y , pred_train );
end
title( "Training Set (crosses=errors)" , "FontSize" , 14 );


% Calculate test dataset error (generalisation):
pred_test = predict(Theta1, Theta2, Xtest);
fprintf( "\n** Test Set Accuracy: %.1f%% **\n" , ...
	mean(double(pred_test==ytest)) * 100 );

% (NB) Visualise test set errors onto Figure 1 subplot:
figure( 1 );
subplot( 2 , 2 , 4 ); hold on;
if (ndim == 2 )
  visualiseerror2D( Xtest , ytest , pred_test );
else
  visualiseerror( Xtest , ytest , pred_test ); 
end
title( "Test Set (crosses=errors)" ,
      "FontSize" , 14 );


% (NB) Visualise snapshots of neural network learned weights:
if (ndim == 2)
  figure( 3 );
  for i = 1:3
    q_params = qweights{ 1 , i };
    QTheta1 = reshape( q_params( 1 : nhiddenunits * ( ndim + 1 ) ) , ...
                 nhiddenunits , ( ndim + 1 ) );

    QTheta2 = reshape( q_params( ( 1 + ( nhiddenunits * ( ndim + 1 ) ) ) : end ) , ...
                 nclasses , ( nhiddenunits + 1 ) );
    subplot( 2 , 2 , i ); hold on;
    D = visualiseNNoutput( QTheta1 , QTheta2 );
    title( ["Weights at quartile ", num2str( i ) ] ,
	  "FontSize" , 14 );
  end
  subplot( 2 , 2 , 4 ); hold on;
    D = visualiseNNoutput( Theta1 , Theta2 );
    title( "Final learned weights" ,
	  "FontSize" , 14 );
end



