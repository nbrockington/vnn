function [J grad] = vecCostFunction(nn_params, ...
                                   n_units, ...
                                   X, y, lambda)
%VECCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = VECCOSTFUNCTON( nn_params, n_units, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%
%
% Edited by Nela Brockington, July 2022, London U.K.
% - original code from Ng ML Coursera course: "nnCostFunction.m"
% - edited to generalise backpropagation algorithm to work for multiple
%   hidden layers, not just one 
% - also edited to vectorise backpropagation algorithm over training
%   examples for faster processing


  
% ====================== SET UP ======================

% Calculate number of training examples:
m = size( X , 1 );  

% Set up cell array of empty matrices to hold Theta weights:
n_layers = size( n_units , 2 );
Thetas{ 1 , n_layers - 1 } = [];
idx_start = 0;

% Reshape nn_params back into a cell array of Theta weight matrices:
for d = 1:( n_layers - 1 )

  idx_end = idx_start + n_units( d + 1 ) * ( n_units( d ) + 1 );

  Thetas{ d } = reshape( nn_params( idx_start + 1 : idx_end ), ...
            		n_units( d + 1 ), ...
			n_units( d ) + 1 );
  idx_start = idx_end;
end		

         
% ====================== FORWARD PROPAGAION ======================

% Add bias term to the input layer:
X = [ ones( m , 1 ) X ] ;

% Set up cell arrays for activation levels of network layers:
a{ 1 , n_layers } = [];
z{ 1 , n_layers-1 } = [];
a{ 1 } = X;

% Implement forward propagation as a loop over Theta weights:
for d = 1:( n_layers - 1 )
  z{ d } = Thetas{ d } * a{ d }' ;
  a{ d+1 } = sigmoid( z{ d }' );
  a{ d+1 } = [ ones( m , 1 ) a{ d+1 } ];
end  
hTheta = a{ n_layers }( : , 2:end );

% Recode y-labels as vectors:
yVec = zeros( m , n_units(3) ) ;

for q = 1:m
  yVec( q , y( q ) ) = 1 ;
end

% Calculate cost function without regularisation:
J = ( 1 / m ) * ...
    sum( sum( - yVec .* log( hTheta ) - (1 - yVec) .* log( 1 - hTheta )));

% Add regularization of Theta weights to cost function
for d = 1:( n_layers - 1 )
  J = J + (lambda / ( 2 * m ) ) * ...
      sum( sum( (Thetas{ d }( : , 2:end ).^2 )));
end


% ====================== BACKPROPAGAION ======================

% Set up deltas cell array: 
deltas{ 1 , n_layers-1 } = [];

% Set up capital-delta matrices to zeros in cell array: 
capDeltas{ 1 , n_layers - 1 } = [];

for d = 1:( n_layers-1 )
  capDeltas{ d } = zeros( size( Thetas{ d } ) );
end

% Implement backpropagation algorithm vectorised over all m training
% examples and loop through Theta matrices:

for d = ( n_layers - 1 ): -1 : 1

  % ouput layer error is simply (hTheta - yVec)
  if d == n_layers-1 
    deltas{ d } = hTheta - yVec ;
  else
    deltas{ d } = ( deltas{ d+1 } * Thetas{ d+1} ) .* ...
	( a{ d+1 } .* ( 1 - a{ d+1 } ) );
    deltas{ d } = deltas{ d }( : , 2:end );
  end

  capDeltas{ d } = capDeltas{ d } + deltas{ d }' * a{ d };

end

% Obtain theta gradients for cost function and add regularisation (but
% not to bias terms):
Theta_grads{ 1 , n_layers - 1 } = [];

for d = 1:( n_layers-1 )
  Theta_grads{ d } = capDeltas{ d } / m + ( lambda / m ) * ...
      [ zeros( n_units( d+1 ) , 1 ) Thetas{ d }( : , 2:end ) ] ;
end


% Unroll gradients into long vector to be returned:
grad = [];
for d = 1:( n_layers-1 )
  grad = [ grad ; Theta_grads{ d }(:) ];
end


end