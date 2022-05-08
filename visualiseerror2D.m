function visualiseerror2D( X , y , pred)
% VISUALISEERROR2D For the special case of 2D data:
% Plot the dataset on a scatter plot and then on top of
% that plot the predicted labels from the trained neural network, to
% visualise the accuracy of the categorisaton.
% 
% NB. The calling subroutine is expected to set up the figure.
%  
% - matrix X contains the data, vector y contains the labels
% - vector pred contains the predictions of the neural network
%  
% Written by Nela Brockington, 19th April 2022, London, U.K.


  % Set colour table for up to four data classes: 
  colours = { [ 0 0.4470 0.7410 ] ,       % blue-ish
             [ 0.6350 0.0780 0.1840 ] ,   % bordeaux-ish
	     [ 0.4660 0.6740 0.1880 ] ,   % green-ish	     
	     [ 0.9290 0.6940 0.1250 ] };  % orange-ish

  % Set axes
  hold on;
  axis( [-10 10 -10 10] );  


  % For each data class: 
  for c = 1:size( unique( y ) , 1 )

    % Verbose output
    fprintf( "\n...\nPlotting data for class %d\n...\n" , c ) ;

    
    % Plot the data from that class onto a 2D scatter plot: 
    scatter( X( find( y==c ) , 1 ) , X( find( y==c ) , 2 ) ,
	    1 , colours{c} , '.' );

    % In lieu of legend(?!!), add text to indicate class label colour
    text( 7 , 10-2*c , strcat( "class:" , num2str( c ) ) , "color" ,
	 colours{c} , "FontSize" , 16 );

  end

  % For each data class
  for c = 1:size( unique( y ) , 1 )

    % Plot incorrect classifications to that class in the shape of crosshairs: 
    scatter( X( find( y!=pred & pred==c) , 1 ) , X( find( y!=pred & pred==c) , 2 ) ,
	     [14] , colours{c} , '+' );
  end
  
  % Set background colour to be white [currently not working??]
  f = gcf() ;
  set( f , 'color' , 'w' );

  
end  