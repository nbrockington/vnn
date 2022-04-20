function [ X , y , Xcv , ycv , Xtest , ytest ] = gen3datasets( shapefun ,
			      ndim , nexamples ,  nclasses , noise =  0.25 )
% GEN3DATASETS Generate training, cross-validation and test datasets for
% a neural network. 
%
% Calls the function GENDATASET to generate the data and then splits the
% data into the three datasets required, and then randomly permutes the
% data. 
%  
% Visualises the training, cross-validation, and test datasets
% separately. 
% 

% NB. nexamples argument controls the number of examples of each class
% in the training set. The sizes of the cross-validation and test
% datasets will depend on the total size of the training dataset
% according to the 60%/20%/20% rule. [So total size of training dataset
% is nexamples * nclasses.]
%
% Written by Nela Brockington, 18th April 2022, London, U.K. 

  % Calculate number of examples in each class for cross-validation and
  % testing datasets
  nexcv = ceil( nexamples / 3 );
  nextest = nexcv
  
  % Calculate number of examples of each class in total for 3 datasets:
  ndata = nexamples + nexcv + nextest ;
  
  % Calculate how large each dataset needs to be and set up value of m
  m = nexamples * nclasses ;               % total size of training set
  mcv = nexcv * nclasses ;                 % total size of cv set
  mtest = mcv ;                            % total size of test set

  % Set up the output variables for each dataset:
  X = zeros( m , ndim );
  y = zeros( m , 1 );
  Xcv = zeros( mcv , ndim );
  ycv = zeros( mcv , 1 );
  Xtest = zeros( mtest , ndim );
  ytest = zeros( mtest , 1 );

  size(X)
  size(y)

  % Generate all the data
  [ Xfull , yfull ] = gendataset( shapefun , ndim , ndata , nclasses );

  % Split full dataset into training, cross-validation, and testing subsets for
  % each class: 
  for c = 1:nclasses

    X( nexamples * (c-1) + 1 : nexamples * c , : ) = ...
	Xfull( ndata * (c-1) + 1 : ndata * (c-1) + nexamples, : );
    y( nexamples * (c-1) + 1 : nexamples * c , : ) = ...
	yfull( ndata * (c-1) + 1 : ndata * (c-1) + nexamples, : );
    Xcv( nexcv * (c-1) + 1 : nexcv * c , : ) = ...
	Xfull( ndata * (c-1) + nexamples + 1 : ndata * (c-1) +
		nexamples + nexcv , : );
    ycv( nexcv * (c-1) + 1 : nexcv * c , : ) = ...
	yfull( ndata * (c-1) + nexamples + 1 : ndata * (c-1) +
                nexamples + nexcv , : );
    Xtest( nextest * (c-1) + 1 : nextest * c , : ) = ...
	Xfull( ndata * (c-1) + nexamples + nexcv + 1 : ndata * (c-1) +
                nexamples + nexcv + nextest , : );
    ytest( nextest * (c-1) + 1 : nextest * c , : ) = ...
	yfull( ndata * (c-1) + nexamples + nexcv + 1 : ndata * (c-1) +
                nexamples + nexcv + nextest , : );

  end
  

  % Randomise each subset
  randrows = randperm( m );
  X = X( randrows , : );                                                               
  y = y( randrows , : );

  randrows = randperm( mcv );
  Xcv = Xcv( randrows , : );
  ycv = ycv( randrows , : );

  randrows = randperm( mtest );
  Xtest = Xtest( randrows , : );
  ytest = ytest( randrows , : );

  
  
  % Visuliase each subset with verbose output
  % -- 2D data plotted on 2D scatter plot
  % -- For n-D data, n >= 3, first 3 dimensions are plotted onto a 3D
  % scatter plot.  
  fprintf( "\n********\nVisualising TRAINING data\n...\n" );
  if (ndim == 2)
    visualisedata2D( X , y );
  else
    visualisedata( X( : , 1:3 ) , y );
  end
  title( "Training Dataset" , "FontSize" , 18 );
  
  fprintf( "\n********\nVisualising CROSS-VALIDATION data\n...\n" );
  if (ndim == 2)
    visualisedata2D( Xcv , ycv );
  else
    visualisedata( Xcv( : , 1:3 ) , ycv );
  end
  title( "Cross-Validation Dataset" , "FontSize" , 18 );
  
  fprintf( "\n********\nVisualising TEST data\n...\n" );
  if (ndim == 2 )
    visualisedata2D( Xtest , ytest );
  else
    visualisedata( Xtest( : , 1:3 ) , ytest );
  end
  title( "Test Dataset" , "FontSize" , 18 );  

end



  
  




  