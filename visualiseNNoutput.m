function D = visualiseNNoutput( Theta1 , Theta2 )
% VISUALISENNOUTPUT Given the weights of the neural network, plot the
% predicted labels of data points covering 2D input space.
%
% NB. The 2D input space is currently fixed to be -10 to 10, -10 to 10. 
% 
% - 
% Written by Nela Brockington, 19th April 2022, London, U.K. 

% Create a 'pale' colour table for up to four data classes:
  colours = { [ 0.3 0.7 0.95 ] ,       % blue-ish
	      [ 0.9 0.3 0.5 ] ,  % bordeaux-ish
	      [ 0.7 0.85 0.3 ] ,  % green-ish
              [ 1 0.9 0.4 ] }; % orange-ish

% Load matrix of data points covering the input space
load( 'vismatrixdata.mat' );
  
% Create a matrix of data points covering the input space
% D = [];
% i = 1;
% for x = -10 : 0.15 : 10
%   for y = -10 : 0.15 : 10
%     D( i , : ) = [ x , y ];
%     i += 1;
%   end
% end

% Calculate the neural network categorisation over the input space
p = predict( Theta1 , Theta2 , D );

% Create a new figure and hold on; set axes                                             
% figure; hold on;
axis( [-10 10 -10 10] );

% For each data class:                                                                  
for c = 1:size( unique( p ) , 1 )

  % Plot the data from that class onto a 2D scatter plot                                
  scatter( D( find( p==c ) , 1 ) , D( find( p==c ) , 2 ) ,
             [1.5] , colours{c} , 'filled' );

  % In lieu of legend(?!!), add text to indicate class label colour                     
  text( 7 , 10-2*c , strcat( "class:" , num2str( c ) ) , "color" ,
         colours{c} , "FontSize" , 16 );

end




  













  