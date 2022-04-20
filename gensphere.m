function X = gensphere( ndim, ndata , noise = 0.25 )
% GENSPHERE Generate ndata-many data points taken randomly from the
% surface of an n-D sphere. Radius will be randomly selected between 0.1
% and 7.5.
%  
% Spatial noise is added to the x-, y-, and z-coordinates of each data
% point.   
%
% Written by Nela Brockington, 14th April 2022, London, U.K. 

  % Creating the variable to hold the data points
  X = zeros( ndata , ndim ) ;

  % Randomly selecting a radius between 0.1 and 7.5
  radius = unifrnd( 0.1 , 7.5 , 1 );

  % Verbose output
  fprintf( "\n...\nGenerating sphere with radius %f\n...\n" , radius );

  % Creating ndata-many data points
  for n = 1:ndata

    % Sample a 3D coordinate from a normal distribution in each dim
    w = normrnd( 0 , 0.5 , 1 , ndim ) ;

    % Calculate the distance of the coordinate from origin
    lambda = sqrt( sum( w.^2 ) );
  
    % Normalise the coordinate to unit sphere then multiply by radius
    x = radius * w ./lambda ;

    % Sample "noise" values in each dimension from a normal dist
    s = normrnd( 0 , noise , 1 , ndim ) ;  

    % Update the dataset with the new values plus added noise
    X( n , : ) = x + s ;
  end
  

end
