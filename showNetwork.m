function figref = showNetwork( Thetas , k = 1 )
%% SHOWNETWORK Given the weights of a neural network, create a
%% figure showing the structure of the neural network. 
%%
%% FIGREF = SHOWNETWORK( Th1 , Th2 ) creats a figures showing the
%% structure of the neural network, given weight matrices Th1 and Th2.
%% 
%% - Thetas is a cell array holding the Theta matrices describing the
%% edge weights between units of each layer of the network
%% - k is a constant that controls thickness range of the plotted edges,
%% based on weights
%%
%%  
%% NB. Number of layers is currently fixed to 3.
%%  
%% Written by Nela Brockington, June 2022, London, U.K.

  % Work out key variables from Thetas cell array structure:
  n_layers = size(Thetas, 2) + 1;
  Th1 = Thetas{ 1 };
  Th2 = Thetas{ 2 };

  % Number of units in each layer, including bias unit if present:
  n_units = zeros( 1 , n_layers );
  
  for l = 1:n_layers - 1 
    n_units( l ) = size( Thetas{ l } , 2 );
  end

  n_units( end ) = size( Thetas{ n_layers-1 } , 1 );
  
  % Maximum number of units in any layer:
  max_n = max( n_units );

  % Spacings between units in each layer:
  spaces = floor( max_n ./ n_units );

  % Lowest unit y-coordinate in each layer: 
  starts = max_n - spaces .* ( n_units-1 );

  % Create a cell array called "xy" in which each cell is a matrix
  % holding the x and y coordinates of each unit in the figure:
  xy{ 1 , n_layers } = [];

  for l = 1:n_layers
    xy{ l } = ones( n_units( l ) , 1 ) * l ;

    if l < n_layers
      xy{ l } += 0.01; % Add x-coordinate offset to bias units
    end

  end
  
  x1 = xy{ 1 };% ones( n1 , 1 ) * 1 ;
  x2 = xy{ 2 };% ones( n2 , 1 ) * 2 ;
  x3 = xy{ 3 };% ones( n3 , 1 ) * 3 ;

  % Calculating y-coordinates of each unit in each layer:  
  for l = 1:n_layers
    xy{ l }( : , 2 ) = [ max_n : -spaces( l ) : starts( l ) ]' ;
  end

  y1 = xy{ 1 }( : , 2 );% [ max_n : -spaces1 : start1 ]' ;
  y2 = xy{ 2 }( : , 2 );% [ max_n : -spaces2 : start2 ]' ;
  y3 = xy{ 3 }( : , 2 );% [ max_n : -spaces3 : start3 ]' ;
  
  %% SHOW NETWORK
  % Create figure to show neural network, and get its handle: 
  % Setting a large figure 
  figure( 'Position' , [500 , 500 , 800 , 600 ] ) ;
  figref = gca + 1 ;
  hold on;
  axis( [ 0.5 , 3.5 , 0 , max_n+2 ] );

  grey = [ 0.5 , 0.5 , 0.5 ];

  % Plot the weights as edges between units. Positive weights are
  % plotted as solid black lines; negative weights are plotted as dashed
  % mid-grey lines. 

  % Setting width constant to control thickness range of weights: 
  widthconst = zeros( 1 , n_layers-1 );

  for l = 1:n_layers-1
    widthconst( l ) = k / max( max( Thetas{ l } ) );
  end


  %% VISUALISING STRENGTH OF NETWORK CONNECTIONS
  % Plotting network edges onto the figure:
  for l = 1:n_layers-1 % for each weight matrix

    % Number of units in the source layer
    n_source = n_units( l );

    % Number of units in destination layer, excluding bias unit
    n_dest = n_units( l+1 );

    % If destination layer *is* the output layer, then there is no bias
    % unit so project weights to all units; correct for shift in Theta
    % matrix indexing due to bias unit:
    first_idx = 2;
    toggle = -1;
    if l == n_layers-1 
      first_idx = 1;
      toggle = 0;
    end
    
    for j = 1:n_source % source layer

      for i = first_idx:n_dest % destination layer

	if Thetas{ l }( i+toggle , j ) < 0 % negative weights in grey

	  plot( [ xy{ l }( j , 1 ) , xy{ l+1 }( i , 1 ) ] , ...
                [ xy{ l }( j , 2 ) , xy{ l+1 }( i , 2 ) ] , ...
	       '-' , ...
	       'Color' , grey , ...
	       'LineWidth' , ...
	       abs( Thetas{ l }( i+toggle , j ) * widthconst( l ) ) ) ;
	else % positive weights in colour
	  plot( [ xy{ l }( j , 1 ) , xy{ l+1 }( i , 1 ) ] , ...
                [ xy{ l }( j , 2 ) , xy{ l+1 }( i , 2 ) ] , ...
	       'r-' , ...
	       'LineWidth' , ...
	       abs( Thetas{ l }( i+toggle , j ) * widthconst( l ) ) ) ;
	end
      end 
    end
  end


%% VISUALISING UNIT FEATURE FILTERS
  % Create a list of coordinates that sample the input space:
  D = createInputSpaceSampling( 2 , -9 , 9 );   
  m = size( D )( 1 );
  
  % Create a 1 x n_layers cell array with three cells, one for each layer.
  % Each cell contains an i*j matrix where i is the number of samples of
  % the data space and j is the number of units in the layer. The matrix
  % holds the activation level of the unit for that data sample.

  features( 1 , : ) = { ones( m , n_units( 1 ) ) };
  features( 2 , : ) = { ones( m , n_units( 2 ) ) };
  features( 3 , : ) = { ones( m , n_units( 3 ) ) };

  % Calculate feature filters for units in input layer: 
  features{ 1 , 1 }( : , 2 : 3 ) = D;
  
  % Plot colour map of feature filters for second unit (X) in input
  % layer:
  Dtemp(:,1) = D(:,1) .* 0.025 .* ( 2.5 / (max_n + 2 ) );
  Dtemp(:,2) = D(:,2) .* 0.025 ;

  Dtemp(:,1) += x1( 2 );
  Dtemp(:,2) += y1( 2 );

  scatter( Dtemp(:,1) , Dtemp(:,2) , [4.0] , D(:,1) , "filled" );
  colormap( hot );

  minx = min( Dtemp(:,1) );
  maxx = max( Dtemp(:,1) );
  miny = min( Dtemp(:,2) );
  maxy = max( Dtemp(:,2) );

  plot( [ minx , minx ] , [ miny , maxy ] , 'k-' );
  plot( [ minx , maxx ] , [ miny , miny ] , 'k-' );
  plot( [ minx , maxx ] , [ maxy , maxy ] , 'k-' );
  plot( [ maxx , maxx ] , [ miny , maxy ] , 'k-' );
  
  
  % Plot the bias units in black: 
%  plot( x1( 1 ) , y1( 1 ) , 'ks' , 'MarkerFaceColor' , 'k' , ...
%       'MarkerSize' , 12 );
  plot( x2( 1 ) , y2( 1 ) , 'ks' , 'MarkerFaceColor' , 'k' , ...
       'MarkerSize' , 12 );
       
  % Plot the rest of the units in blue:
%  plot( x1( 2 : end ) , y1( 2 : end ) , 'bs' , ...
%       'MarkerFaceColor' , 'b' , 'MarkerSize' , 12 );
  plot( x2( 2 : end ) , y2( 2 : end ) , 'bs' , ...
       'MarkerFaceColor' , 'b' , 'MarkerSize' , 12 );
  plot( x3 , y3 , 'bs' , 'MarkerFaceColor' , 'b' , 'MarkerSize' , 12 );

  % Turn axes off:
  axis off;