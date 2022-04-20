function visualiseerror( X , y , pred)
% VISUALISEERROR Plot dataset on a 3D scatter plot and then on top of
% that plot the predicted labels from the trained neural network, to
% visualise the accuracy of the categorisaton.
% 
% - matrix X contains the data, vector y contains the labels
% - vector pred contains the predictions of the neural network
%  
% Written by Nela Brockington, 15th April 2022, London, U.K.


  % Set colour table for up to four data classes: 
  colours = { [ 0 0.4470 0.7410 ] ,       % blue-ish
             [ 0.6350 0.0780 0.1840 ] ,   % bordeaux-ish
	     [ 0.4660 0.6740 0.1880 ] ,   % green-ish	     
	     [ 0.9290 0.6940 0.1250 ] };  % orange-ish

  
  % Create a new figure and hold on:
  figure; hold on;

  % For each data class: 
  for c = 1:size( unique( y ) , 1 )

    % Verbose output
    fprintf( "\n...\nPlotting data for class %d\n...\n" , c ) ;

    
    % Plot the data from that class onto a 3D scatter plot: 
    scatter3( X( find( y==c ) , 1 ) , X( find( y==c ) , 2 ) ,
	     X( find( y==c ) , 3 ) , [] , colours{c} , '.' );

    % In lieu of legend(?!!), add text to indicate class label colour
    text( 5 + (c-1)*2 , 10-2*c , strcat( "class " , num2str( c ) ) , "color" ,
	 colours{c} , "FontSize" , 16 );

  end

  % For each data class
  for c = 1:size( unique( y ) , 1 )

    % Plot incorrect classifications to that class in the shape of crosshairs: 
    scatter3( X( find( y!=pred & pred==c) , 1 ) , X( find( y!=pred & pred==c) , 2 ) ,
	   X( find( y!=pred & pred==c) , 3 ) , [14] , colours{c} , '+' );
  end
  
  % Set background colour to be white:
  f = gcf() ;
  set( f , 'color' , 'w' );

  
end  