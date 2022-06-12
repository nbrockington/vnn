function figref = showNetwork( Th1 , Th2 )
%% SHOWNETWORK Given the weights of a neural network, create a
%% figure showing the structure of the neural network. 
%%
%% FIGREF = SHOWNETWORK( Th1 , Th2 ) creats a figures showing the
%% structure of the neural network, given weight matrices Th1 and Th2.
%% 
%% - Th1 is the matrix holding the weights between input layer and
%% hidden layer (including bias unit in input layer)
%% - Th2 is the matrix holding the weights between the hidden layer and
%% the output layer (including bias unit in hidden layer)
%%  
%% NB. Number of layers is currently fixed to 3.
%%  
%% Written by Nela Brockington, June 2022, London, U.K.

  % Number of units in each layer, including bias unit if present:
  n1 = size( Th1 , 2 );
  n2 = size( Th2 , 2 );
  n3 = size( Th2 , 1 ) ;

  % Maximum number of units in any layer:
  max_n = max( [n1 , n2 , n3 ] );

  % Spacings between units in each layer:
  spaces1 = floor( max_n / n1 );
  spaces2 = floor( max_n / n2 );
  spaces3 = floor( max_n / n3 );

  % Lowest unit y-coordinate in each layer: 
  start1 = max_n - spaces1 * ( n1 - 1 );
  start2 = max_n - spaces2 * ( n2 - 1 );
  start3 = max_n - spaces3 * ( n3 - 1 );

  % Calculating x-coordinates of each unit in each layer:
  x1 = ones( n1 , 1 ) * 1 ;
  x2 = ones( n2 , 1 ) * 2 ;
  x3 = ones( n3 , 1 ) * 3 ;

  % Add x-coordinate offset to bias units (except output layer):
  x1( 1 ) += 0.15;
  x2( 1 ) += 0.15;
  
  % Calculating y-coordinates of each unit in each layer:  
  y1 = [ max_n : -spaces1 : start1 ]'
  y2 = [ max_n : -spaces2 : start2 ]'
  y3 = [ max_n : -spaces3 : start3 ]'
  
  %% SHOW NETWORK
  % Create figure to show neural network, and get its handle: 
  % Setting a large figure 
  figure( 'Position' , [500 , 500 , 800 , 600 ] ) ;
  figref = gca + 1 ;
  hold on;
  axis( [ 0.8 , 3.2 , 0 , max_n+2 ] );

  grey = [ 0.5 , 0.5 , 0.5 ];

  % Plot the weights as edges between units. Positive weights are
  % plotted as solid black lines; negative weights are plotted as dashed
  % mid-grey lines. 

  % Plotting input layer to hidden layer: 
  for j = 1:n1 % input layer

    for i = 1:(n2-1) % output layer, excluding bias unit

      if Th1( i , j ) < 0

	plot( [ x1( j ) , x2( i+1 ) ] , [ y1( j ) , y2( i+1 ) ] , ...
	   '-' , ...
	   'Color' , grey , ...
	   'LineWidth' , abs( Th1( i , j ) * 4 ) ) ;
      else
	plot( [ x1( j ) , x2( i+1 ) ] , [ y1( j ) , y2( i+1 ) ] , ...
	   'k-' , ...
	   'LineWidth' , abs( Th1( i , j ) * 4 ) ) ;
      end
    end 
  end


    % Plotting hidden layer to output layer: 
  for j = 1:n2 % hidden layer

    for i = 1:n3 % output layer

      if Th2( i , j ) < 0

	plot( [ x2( j ) , x3( i ) ] , [ y2( j ) , y3( i ) ] , ...
	   '-' , ...
	   'Color' , grey , ...
	   'LineWidth' , abs( Th2( i , j ) * 4 ) );
      else
	plot( [ x2( j ) , x3( i ) ] , [ y2( j ) , y3( i ) ] , ...
	   'k-' , ...
	   'LineWidth' , abs( Th2( i , j ) * 4 ) );
      end
    end 
  end





  
  % Plot the bias units in red: 
  plot( x1( 1 ) , y1( 1 ) , 'rs' , 'MarkerFaceColor' , 'r' , ...
       'MarkerSize' , 12 );
  plot( x2( 1 ) , y2( 1 ) , 'rs' , 'MarkerFaceColor' , 'r' , ...
       'MarkerSize' , 12 );
       
  % Plot the rest of the units in blue:
  plot( x1( 2 : end ) , y1( 2 : end ) , 'bs' , ...
       'MarkerFaceColor' , 'b' , 'MarkerSize' , 12 );
  plot( x2( 2 : end ) , y2( 2 : end ) , 'bs' , ...
       'MarkerFaceColor' , 'b' , 'MarkerSize' , 12 );
  plot( x3 , y3 , 'bs' , 'MarkerFaceColor' , 'b' , 'MarkerSize' , 12 );

  % Turn axes off:
  axis off;