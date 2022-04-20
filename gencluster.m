function X = gencluster( ndim , ndata , noise = 1.0 )
% GENCLUSTER Generate ndata-many data points centred around a cluster in
% n-D space. Centre of cluster will be randomly selected between -7.5 and
% 7.5 in each dimension. 
%
% Spacial noise is added to the x-, y-, and z-coordinates of each data
% point. 
%
% Written by Nela Brockington, 15th April 2022, London, U.K. 

  % Creating the variable to hold hte data points
  X = zeros( ndata , ndim );

  % Randomly selecting a cluster centre coordinate in n-D space:
  centre = unifrnd( -7.5 , 7.5 , 1 , ndim );

  % Verbose output
  fprintf( "\n...\nGenerating cluster with centre: (" ) ;
  fprintf( "%f " , centre );
  fprintf( ")\n...\n ");

  
  % Creating ndata-many data points
  for n = 1:ndata

    % Sample "noise" values in each dimension from a normal dist
    s = normrnd( 0 , noise , 1 , ndim );

    % Update the dataset with the new values plus added noise
    X( n , : ) = centre + s ;
  end

end

  