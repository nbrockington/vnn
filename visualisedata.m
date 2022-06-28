function visualisedata( X , y )
% VISUALISEDATA Plot dataset on a 3D scatter plot 
% NB. The calling subroutine is expected to set up the figure.
%  
% - scatter points are coloured according to their class label 
% - matrix X contains the data, vector y contains the labels
% - currently up to maximum 4 data labels
% 
% Written by Nela Brockington, 15th April 2022, London, U.K.


  % Set colour table for up to four data classes: 
  colours = { [ 0 0.4470 0.7410 ] ,       % blue-ish
             [ 0.6350 0.0780 0.1840 ] ,   % bordeaux-ish
	     [ 0.4660 0.6740 0.1880 ] ,   % green-ish	     
	     [ 0.9290 0.6940 0.1250 ] };  % orange-ish

  % Create a 'dark' colour table for up to four data classes:
  darker = { [ 0.2 0.25 0.65 ] , % blue-ish
	    [ 0.6 0.2 0.35 ] ,  % bordeaux-ish
	    [ 0.25 0.6 0.2 ] , % green-ish
	    [ 0.65 0.6 0.35 ] };   % orange-ish
  
  
  % Create a new figure and hold on; control background colour:
  % figure; hold on;

  % For each data class: 
  for c = 1:size( unique( y ) , 1 )

    % Verbose output
    fprintf( "\n...\nPlotting data for class %d\n...\n" , c ) ;

    
    % Plot the data from that class onto a 3D scatter plot
    scatter3( X( find( y==c ) , 1 ) , X( find( y==c ) , 2 ) ,
	     X( find( y==c ) , 3 ) , [] , colours{c} , 'filled' );

    hold on;
    % In lieu of legend(?!!), add text to indicate class label colour
    text( 5 + (c-1)*2 , 10-2*c , strcat( "class:" , num2str( c ) ) , "color" ,
	 darker{c} , "FontSize" , 16 );

  end

 % Set background colour to be white:
 %  f = gcf() ;
 %  set( f , 'color' , 'w' );
  
end  