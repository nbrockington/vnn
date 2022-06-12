# VNN (Octave/MATLAB)

![Neural Network Visualisations](220515_vnn1_visuals.png)

![Show Structure](220612_showNetworkfig.png)

Run with command `>> vnn` on MATLAB/Octave command prompt.

Visualise the learning of a toy neural neural network on
multidimensional data.

Neural network/backpropagation/optimisation code comes from Andrew
Ng's Coursera ML course
https://www.coursera.org/learn/machine-learning

Generation and visualisation of cluster and spehre datasets from
distributions, and visualisation of cost function and neural network
filters during learning, are my own work.

Inspiration taken from TensorFlow Neural Network Playground
https://playground.tensorflow.org/


# Current functionality

-- vnn: Script to upload a cluster or spherical dataset and view it;
   set random weights to the neural network and visualise the intial
   network state; train the neural network on the data; view neural
   network performance on training and test datasets and visualise
   final categorisation of dataset space.

-- Currently, only 2D data can be visualised (although nD data can be
   learned for any n>1).

-- Currently, only a neural network with 3 layers can be specified and
   visualised.


# Functionality to add

-- Change training snapshots to occur at early points in training,
   instead of quartiles.

DONE-- Visualise final neural network structure and weights for 2D
   data training.

DONE-- Implement user choice of number of units in the hidden layer, with
   immediate visualistion of randomly initialised weights.

-- Add visualisation of cost function on Test Set data during training
   (to fmincgv.m)

DONE-- Add neural network % performance to subplot titles for final
   Training Set and Test Set visualisations (to vnn1.m)

-- Implement user choice for uploading saved dataset or generating new
   dataset (via menu interface)

-- Visualisation of neural network learning and hidden units fo n-D
   data, n >= 3, on 2D and 3D scatter plots.

-- Make neural network structure (no. of hidden layers, number of
   units in each layer) flexible and selected by user

-- More dataset distribution shapes, including "ribbons"

-- Implement validation step(s) between training and testing



# Known bugs
-- Has only been tested on OS X (MacBook Pro)

-- On older OX S systems, such as Mojave 10.14.6 and earlier, when
   using Octave with GNUPLOT qt, 3D scatter plot background is black
   by default and must be changed to white manually by user at the
   start of the backpropagation learning process to improve
   visualisation.


