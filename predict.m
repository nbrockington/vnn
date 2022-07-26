function p = predict(Thetas, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT( Thetas , X ) outputs the predicted label of X given the
%   trained weights of a neural network cell array Thetas.
%
% Edited by Nela Brockington, 26th July 2022, London, U.K.
% - generalised to multiple hidden layers
  
% Useful values
m = size( X , 1 );
num_labels = size( Thetas{ end } , 1 );
n_Thetas = size( Thetas , 2 );

p = zeros( size( X , 1 ) , 1 );

% (NB) Calculate neural network's categorisation of dataset X:
h{ 1 , n_Thetas + 1 } = [];
h{ 1 } = X;

for d = 1: n_Thetas
  h{ d+1 } = sigmoid( [ ones( m , 1 ) h{ d } ] * Thetas{ d }' );
end

[dummy, p] = max( h{ end } , [] , 2 );

%h1 = sigmoid([ones(m, 1) X] * Theta1');
%h2 = sigmoid([ones(m, 1) h1] * Theta2');
%[dummy, p] = max(h2, [], 2);

% =========================================================================


end
