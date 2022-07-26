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
% accuracy is plotted in 2D or 3D, with crosses showing incorrect
% classifications in the input space. 
%
%
%  ** IMPORTANT **
%  ** Original neural network code was written by the instructors of the
%  Coursera Machine Learning course by Andrew Ng. I have extended
%  this code to handle variable data and parameter dimensions, multiple
%  hidden layers in the neural network, and visualisation of the data,
%  training, classification, and network structure.
%  
%  Edited by Nela Brockington, June-July 2022, London, U.K.
%  Edits indicated by (NB) comments.


%% --------Initialization----------------------------------------
clear all; close all; clc;
                    

% (NB) User menu: Select training data:
fprintf( "***\nWelcome to VNN - visualising a neural network.\n\n" );
fprintf( "Stage 1: Loading and Visualizing Data ...\n\n" );
fprintf( "MENU: Upload dataset or generate new dataset?\n" );
fprintf( "Press 1 to UPLOAD a dataset.\n" );
fprintf( "Press 2 to GENERATE a new dataset.\n" );
upload_choice = input( "Enter choice here: " , "s" );
  
if ( upload_choice == "1" )
  fprintf( "\nMENU: Select data shape to upload:\n" );
  fprintf( "Press 1 to load SPHERICAL data.\n" );
  fprintf( "Press 2 to load CLUSTER data.\n" );
  data_choice = input( "Enter choice here: " , "s" );

  if ( data_choice == "1" )
    load( '2Dspheredata1.mat' ); 
  else
    load( '2Dclusterdata1.mat' );
  end

else
  while true
    clc;
    fprintf( "\nMENU: Select data shape to generate:\n" );
    fprintf( "Press 1 to generate SPHERICAL data.\n" );
    fprintf( "Press 2 to generate CLUSTER data.\n" );
    shape_choice = input( "Enter choice here: " , "s" );

    fprintf( "\nMENU: Select number of LABELS in dataset:\n" );
    fprintf( "Number of labels must be between 2 and 4, inclusive.\n" );
    nclasses = input( "Enter choice here: " );
    while nclasses < 2 || nclasses > 4
      fprintf( "Number of labels must be between 2 and 4, inclusive.\n" );      
      nclasses = input( "Enter choice here: " );
    end
      
    fprintf( "\nMENU: Select number of DATA POINTS per label:\n" );
    fprintf( "Suggested value 500.\n" );
    nexamples = input( "Enter choice here: " );
    while nexamples < 100 || nexamples > 800
      fprintf( "Enter a value between 100 and 800.\n" );
      nexamples = input( "Enter choice here: " );
    end
  
    if ( shape_choice == "1" )
      [X , y, Xcv , ycv , Xtest , ytest] = ...
	  gen3datasets( @gensphere , 2 , nexamples , nclasses );
    else
      [X , y, Xcv , ycv , Xtest , ytest] = ...
	  gen3datasets( @gencluster , 2 , nexamples , nclasses );

    end

    visualisedata2D( X , y , 4 );
    title( "Visualisation of generated training data" , "FontSize" , 14 ); 

    fprintf( "Press 1 to CONTINUE with this dataset.\n" );
    fprintf( "Press 2 to generate a NEW dataset.\n" );
    keep = input( "Enter choice here: " , "s" );
    close all;
    if ( keep == "1" )
      break;
    end
  end
end

% load('clusterdata1.mat');
% load('spheredata1.mat');
% load('spheredata2.mat');
% load('spheredata3.mat');

% Assign number of training examples to variable m:
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

% (NB) User sets number of hidden layers in the network:
n_hidden_layers = input( "Enter the number of hidden layers: " );
while n_hidden_layers < 1 || n_hidden_layers > 5
  fprintf( "No. of hidden layers should be between 1 and 5 inclusive.\n" );
  n_hidden_layers = input( "Enter the number of hidden layers: " );
end

% (NB) Number of units in input layer is set to the dimensionality of the
% data: 
n_units = [ ndim ];

% (NB) User sets number of units in each hidden layer:
for i = 2:( n_hidden_layers + 1 )
  fprintf( "\nSelect the number of units in layer %1i." , i );
  n_units( i ) = input( "\nEnter value here: " );
  while n_units( i ) < 1 || n_units( i ) > 20
    fprintf( "Number of units must be between 1 and 20 inclusive.\n" );
    n_units( i ) = input( "\nEnter value here: " );
  end
end

% (NB) Number of units in output layer is set to number of labels/classes: 
n_units( end+1 ) = size( unique( y ) , 1 );
n_layers = n_hidden_layers + 2;

%% RANDOM INITIALISATION OF WEIGHTS %%
fprintf('\nInitializing Neural Network Parameters ...\n')

% (NB) Initialise random weights in required number of Theta matrices:
for d = 1:( n_layers-1)
  Thetas{ d } = randInitializeWeights( n_units( d ) , n_units( d+1 ) );
end

% (NB) Unroll parameters                                                   
initial_nn_params = [];
for d = 1:( n_layers-1 )
  initial_nn_params = [ initial_nn_params ; Thetas{ d }(:) ];
end


% (NB) Visualise the neural network output from the initial weights:
if (ndim == 2)
  figure( 1 , 'Position' , [ 5 , 450 , 560 , 394 ]);
  subplot( 2 , 2 , 2 ); hold on;
  D = visualiseNNoutput( Thetas );
  title( "Neural network: initial random weights" ,
	"FontSize" , 14 );
end
%close;

% (NB) Show structure of the neural network from initial weights:
featuresInit = showNetwork( Thetas );
title( "Neural network structure: initial random weights" , "FontSize" ,
      14 );


fprintf('\nProgram paused. Press enter to train the neural network.\n');
%pause;

%% --------------------------------------------------------------------
%% TRAINING THE NEURAL NETWORK %% 
fprintf('\nTraining Neural Network... \n')

% Setting up options for optimisation: number of iterations
% NumIter = 100;
NumIter = ...
    input( "Enter number of iterations for training (between 50 and 300 ): " );
options = optimset( 'MaxIter', NumIter );

% Regularisation parameter
lambda = 0.1;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) vecCostFunction( p , ...
                                   n_units , X , y , lambda );

% (NB) Run optimisation with fmincg, collect returned weights at
% snapshots: 
[ nn_params, cost, it, qweights ] = fmincgv( costFunction , ...
				   initial_nn_params , options );


% (NB) Reshape nn_params back into a cell array of Theta matrices:
idx_start = 0;
for d = 1:( n_layers - 1 )

  idx_end = idx_start + n_units( d + 1 ) * ( n_units( d ) + 1 );

  Thetas{ d } = reshape( nn_params( idx_start + 1 : idx_end ), ...
                        n_units( d + 1 ), ...
                        n_units( d ) + 1 );
  idx_start = idx_end;
end



%% ------------------------------------------------------------------------
%% TESTING THE NEURAL NETWORK %%

% Calculate training dataset accuracy:
pred_train = predict( Thetas , X );
train_acc = mean( double( pred_train==y ) ) * 100 ;
fprintf( "\n** Training Set Accuracy: %.1f%% **\n" , train_acc );
	

% (NB) Visualise training set errors onto Figure 1 subplot:
figure( 1 );
subplot( 2 , 2 , 3 ); hold on;
if (ndim == 2)
  visualiseerror2D( X , y , pred_train );
else  
  visualiseerror( X , y , pred_train );
end
title( [ "Training Set ", num2str( round( train_acc*10 )/10 ) , ...
	"% (crosses=errors)" ], "FontSize" , 14 );


% Calculate test dataset accuracy (generalisation):
pred_test = predict( Thetas , Xtest );
test_acc = mean( double( pred_test==ytest ) ) * 100 ;
fprintf( "\n** Test Set Accuracy: %.1f%% **\n" , test_acc );
	

% (NB) Visualise test set errors onto Figure 1 subplot:
figure( 1 );
subplot( 2 , 2 , 4 ); hold on;
if (ndim == 2 )
  visualiseerror2D( Xtest , ytest , pred_test );
else
  visualiseerror( Xtest , ytest , pred_test ); 
end
title( [ "Test Set ", num2str( round( test_acc*10 )/10 ) , ...
      "% (crosses=errors)" ] , "FontSize" , 14 );


% (NB) Visualise snapshots of neural network weights during learning:
if (ndim == 2)
  figure( 4 );

  % For each snapshot:
  for i = 1:3
    
    q_params = qweights{ 1 , i };

    % Reshape the parameters into weight matrices:
    idx_start = 0;
    for d = 1:( n_layers - 1 )
      idx_end = idx_start + n_units( d + 1 ) * ( n_units( d ) + 1 );
      QThetas{ d } = reshape( q_params( idx_start + 1 : idx_end ), ...
			     n_units( d + 1 ), ...
			     n_units( d ) + 1 );
    
%    QTheta1 = reshape( q_params( 1 : nhiddenunits * ( ndim + 1 ) ) , ...
%                 nhiddenunits , ( ndim + 1 ) );

%    QTheta2 = reshape( q_params( ( 1 + ( nhiddenunits * ( ndim + 1 ) ) ) : end ) , ...
%                 nclasses , ( nhiddenunits + 1 ) );


    end
    % Plot the categorisation of input space by those weights:
    subplot( 2 , 2 , i ); hold on;
    D = visualiseNNoutput( QThetas );
    title( ["Weights at snapshot ", num2str( i ) ] ,
	  "FontSize" , 14 );
  end
    
  % Plot result of final learned weights:
  subplot( 2 , 2 , 4 ); hold on;
    D = visualiseNNoutput( Thetas );
    title( "Final learned weights" , "FontSize" , 14 );
end

% (NB) Show structure of the neural network with final learned weights:
featuresFinal = showNetwork( Thetas , 2.5 );
title( "Neural network structure: final learned weights" , "FontSize" , 14 );


