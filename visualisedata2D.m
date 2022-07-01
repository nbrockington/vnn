function visualisedata2D( X , y , dsize = 1 )
% VISUALISEDATA2D Plot the special case of 2D data onto a 2D scatter
% plot. NB. The calling subroutine is explected to set up the figure.
%
%  visualisedata2D( X , y )
%  
% - scatter points are coloured according to their class label 
% - matrix X contains the data, vector y contains the labels
% - dsize controls the size of the scatter dots (default 3 for a large
% figure) 
% - currently up to maximum 4 data labels
%  
% Written by Nela Brockington, 19th April 2022, London, U.K.


  % Create colour table for up to four data classes: 
  colours = { [ 0 0.4470 0.7410 ] ,       % blue-ish
             [ 0.6350 0.0780 0.1840 ] ,   % bordeaux-ish
	     [ 0.4660 0.6740 0.1880 ] ,   % green-ish	     
	     [ 0.9290 0.6940 0.1250 ] };  % orange-ish

  % Create a 'dark' colour table for up to four data classes:
  darker = { [ 0.2 0.25 0.65 ] , % blue-ish
	    [ 0.6 0.2 0.35 ] ,  % bordeaux-ish
	    [ 0.25 0.6 0.2 ] , % green-ish
	    [ 0.65 0.6 0.35 ] };   % orange-ish

  
  % Set axes
  hold on;
  axis( [-10 10 -10 10] );

  % For each data class: 
  for c = 1:size( unique( y ) , 1 )

    % Verbose output
    fprintf( "\n...\nPlotting data for class %d\n...\n" , c ) ;

    
    % Plot the data from that class onto a 2D scatter plot
    scatter( X( find( y==c ) , 1 ) , X( find( y==c ) , 2 ) ,
	     dsize , colours{c} , 'filled' );

    % In lieu of legend(?!!), add text to indicate class label colour
    text( 7 , 10-2*c , strcat( "class:" , num2str( c ) ) , "color" ,
	 darker{c} , "FontSize" , 16 );

  end

end  