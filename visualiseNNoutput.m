function p = visualiseNNoutput( Thetas , res = 0.2 )
% VISUALISENNOUTPUT Given the weights of the neural network, plot the
% predicted labels of data points covering 2D input space.
%
% - Thetas is the cell array of network weights
% - res represents the spacings of dots plotted, 0.2 by default
%
%  NB. The 2D input space is currently fixed to be -10 to 10, -10 to 10. 
% 
% Written by Nela Brockington, 19th April 2022, London, U.K. 
% Edited 26th July 2022

  
hold on;
  
% Create a 'pale' colour table for up to four data classes:
  colours = { [ 0.3 0.7 0.95 ] , % blue-ish
	      [ 0.9 0.3 0.5 ] ,  % bordeaux-ish
	      [ 0.7 0.85 0.3 ] , % green-ish
              [ 1 0.9 0.4 ] };   % orange-ish


% Create a 'dark' colour table for up to four data classes:
  darker = { [ 0.2 0.25 0.65 ] , % blue-ish
	      [ 0.6 0.2 0.35 ] ,  % bordeaux-ish
	      [ 0.25 0.6 0.2 ] , % green-ish
              [ 0.65 0.6 0.35 ] };   % orange-ish


  
% Load matrix of data points covering the input space
% load( 'vismatrixdata.mat' );
  
% Create a list of coordinates sampling the input space
D = createInputSpaceSampling( res );

% Calculate the neural network categorisation over the input space
p = predict( Thetas , D );

% Create a new figure and hold on; set axes                                   
% figure; hold on;
axis( [-10 10 -10 10] );

% For each data class:                                                        
for c = 1:size( Thetas{ end } , 1 )

  % Plot the data from that class onto a 2D scatter plot                      
  scatter( D( find( p==c ) , 1 ) , D( find( p==c ) , 2 ) ,
             [1.5] , colours{c} , 'filled' );

  % In lieu of legend(?!!), add text to indicate class label colour           
  text( 7 , 10-2*c , strcat( "class:" , num2str( c ) ) , "color" ,
         darker{c} , "FontSize" , 16 );

end




  













  