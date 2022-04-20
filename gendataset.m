function [ X , y ] = gendataset( shapefun , ndim , ndata , nclasses ,
				noise = 0.25 )
% GENDATASET Generate a dataset X and labels y for NN training,
%  validation, or testing.
%  
% -- size of output X is (ndata * nclasses x ndim)
% -- size of output y is (ndata * nclasses x 1)
% 
% -- shapefun: @function handle to the function that creates data shape
% (e.g. sphere, cluster, etc.)
% -- ndim: number of dimensions i.e. length of each data-point vector
% -- ndata: number of data points per class (category of data)
% -- nclasses: number of classes (categories of data) [max=4]
% -- noise: amount of noise to add to the data points (default val is 0.25)
%
%
%  Currently, properties of each data class, such as the radius of the
%  sphere or the location of a cluster, is generated randomly. 
%  
% Written by Nela Brockington, 15th April 2022, London, U.K.

  % Creating a matrix to hold the output
  X = zeros( ndata * nclasses , ndim );
  y = zeros( ndata * nclasses , 1 );


  % For each class of data
  for c = 1:nclasses

    % Verbose output
    fprintf( "\n...\nGenerating data for class %d\n...\n" , c );

    % Populate the output data X with values from that class, using
    % default nose values
    % X( ndata*(c-1)+1 : ndata*c , : ) = shapefun( ndim , ndata , noise );
    X( ndata*(c-1)+1 : ndata*c , : ) = shapefun( ndim , ndata );

    % Populate the output labels Y
    y( ndata*(c-1)+1 : ndata*c , : ) = ones( ndata , 1 ) * c ;
  end

  % Get a new randomised  order for the rows of X and Y
  % randrows = randperm( ndata * nclasses );

  % Apply randomised order
  %  X = X( randrows , : );
  % y = y( randrows , : );

  % Show the data in a 3D plot
  % visualisedata( X , y );
  
end