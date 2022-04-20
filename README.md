# VNN (Octave/MATLAB)

Visualise the learning of a toy neural neural network on
multidimensional data.

Neural network/backpropagation/optimisation code comes from Andrew
Ng's Coursera ML course
https://www.coursera.org/learn/machine-learning

Visualisation of learning, generation of datasets, and generalisation
of neural network to arbitrary dimensional data and labels, are my own
work.

Inspiration taken from TensorFlow Neural Network Playground
https://playground.tensorflow.org/


# Current functionality

-- vnn1: Script to upload a cluster or spherical dataset and view it;
   set random weights to the neural network and visualise the intial
   network state; train the neural network on the data; view neural
   network performance on training and test datasets and visualise
   final categorisation of dataset space.

-- Currently, visualising neural network learning is only supported
   for 2D data; however, n-D data can be learned.  


# Functionality to add

-- Visualisation of neural network learning and the decrease in cost
   function (on training data) "live" during weight optimisation
   process, for 2D data

-- Visualise hidden units for 2D data

-- Implement choice about uploading saved dataset or generating new
   dataset (user interface)

-- Visualisation of neural network learning and hidden units fo n-D
   data, n >= 3, on 2D and 3D scatter plots.

-- More dataset shapes, including "ribbons"

-- Implement validation step between training and testing



# Known bugs

-- When using Octave, 3D scatter plot background is black by default
   and must be changed to white manually to see data clearly

