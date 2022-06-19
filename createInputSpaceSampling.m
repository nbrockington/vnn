function D = createInputSpaceSampling( res , min = -10 , max = 10 )
% CREATEINPUTSPACEMATRIX Create a list of coordinates covering the input
% space, sampled with spacings set by the res parameter.
% 
% Currently limited to 2D data input space.
%  
% Written by Nela Brockington, June 2022, London, U.K.

  D = [];
  i = 1;

  for x = min : res : max
    for y = min : res : max
      D( i , : ) = [ x , y ];
      i += 1;
    end
  end
    
  


  

  