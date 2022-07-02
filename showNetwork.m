function features = showNetwork( Thetas , k = 1 )
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
%% Written by Nela Brockington, June-July 2022, London, U.K.

  % Work out key variables from Thetas cell array structure:
  n_layers = size(Thetas, 2) + 1;

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
      xy{ l }(1,1) += 0.01; % Add x-coordinate offset to bias units
    end

  end
  
  % Calculating y-coordinates of each unit in each layer:  
  for l = 1:n_layers
    xy{ l }( : , 2 ) = [ max_n : -spaces( l ) : starts( l ) ]' ;
  end

  
  %% SHOW NETWORK
  % Create figure to show neural network, and get its handle: 
  % Setting a large figure 
  figure( 'Position' , [100 , 500 , 500 , 400 ] ) ;
  figref = gca + 1 ;
  hold on;
  axis( [ 0.5 , n_layers+0.5 , 0 , max_n+2 ] );

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
	       'b-' , ...
	       'LineWidth' , ...
	       abs( Thetas{ l }( i+toggle , j ) * widthconst( l ) ) ) ;
	end
      end 
    end
  end


%% VISUALISING INDIVIDUAL UNIT FEATURES
  % Create a list of coordinates that sample the input space:
  D = createInputSpaceSampling( 2 , -9 , 9 );   
  m = size( D )( 1 );
  
  % Create a 1 x n_layers cell array with one cell for each layer. 
  % Each cell contains an i*j matrix where i is the number of samples of
  % the data space and j is the number of units in the layer. Each matrix
  % element holds the activation level for that data sample at that
  % unit. 

  for l = 1:n_layers
    features( l , : ) = { ones( m , n_units( l ) ) };
  end
    
  %% Calculate feature filters:

  % (1) Input layer
  % First unit is bias unit (leave as ones)

  % Second unit represents the first dimension of the data along the
  % x-axis.

  features{ 1 , 1 }( : , 2 ) = D( : , 1 );

  % Subsequent units represent the remaining dimensions of the data
  % visualised against the y-axis.

  for u = 3:n_units( 1 )
    features{ 1 , 1 }( : , u ) = D( : , 2 );
  end

  % (2) Hidden layers: leave the first column for bias unit
  for l = 2:( n_layers - 1 ) % For each hidden layer
    features{ l }( : , 2:end ) = sigmoid( ...
			 features{ l-1 } * Thetas{ l-1 }' );
  end


  % (3) Output layer
  features{ l+1 } = sigmoid( features{ l } * Thetas{ l }' );

  % Scale the featuers of every unit to lie between -1 and 1 to aid
  % clearer visualistion with the colour map:
  for l = 1:n_layers
    for u = 1:n_units( l )
      features{ l }( : , u ) /= max( features{ l }( : , u ) );
    end				    
  end
  
  %% Plot colour map of feature filters:

  % Scale colour map coordinates down to size
  Dtemp(:,1) = D(:,1) .* 0.03 .* ( 2.5 / (max_n + 2 ) );
  Dtemp(:,2) = D(:,2) .* 0.03;

  for l = 1:n_layers % for each layer
    for u = 1:n_units( l ) % for each unit

      % Translate coordinates to be centred on x,y-coords of the unit:
      Dunit(:,1) = Dtemp(:,1) + xy{ l }( u,1 );
      Dunit(:,2) = Dtemp(:,2) + xy{ l }( u,2 );

      % Plot the unit feature map as specified colour map:
      scatter( Dunit(:,1) , Dunit(:,2) , [5.0] , ...
	      features{ l }(:,u), "filled" );
      colormap( winter );

      % Plot the border around the unit
      minx = min( Dunit(:,1) );
      maxx = max( Dunit(:,1) );
      miny = min( Dunit(:,2) );
      maxy = max( Dunit(:,2) );

      plot( [ minx , minx ] , [ miny , maxy ] , 'k-' );
      plot( [ minx , maxx ] , [ miny , miny ] , 'k-' );
      plot( [ minx , maxx ] , [ maxy , maxy ] , 'k-' );
      plot( [ maxx , maxx ] , [ miny , maxy ] , 'k-' );
    end
  end
    
  % Plot key for data class colours:

  % Create a 'dark' colour table for up to four data classes: 
  darker = { [ 0.2 0.25 0.65 ] , % blue-ish                                  
              [ 0.6 0.2 0.35 ] ,  % bordeaux-ish                             
              [ 0.25 0.6 0.2 ] , % green-ish                                 
              [ 0.65 0.6 0.35 ] };   % orange-ish
  for u = 1:n_units( end )

    if u < 5 % Colours provided for up to four classes

      text( xy{ end }( u , 1 ) + 0.25, xy{ end }( u , 2 ), ...
	   strcat( "class:" , num2str( u ) ) , ...
	   "color" , darker{ u } , "FontSize" , 16 );
    else
      text( xy{ end }( u , 1 ) + 0.25, xy{ end }( u , 2 ), ...
	   strcat( "class:" , num2str( u ) ) , ...
	   "color" , "black" , "FontSize" , 16 );
    end
  end  
  % Turn axes off:
  axis off;