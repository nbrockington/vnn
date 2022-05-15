# VNN (Octave/MATLAB)

![Neural Network Visualisations](220515_vnn1_visuals.png)

Run with command `>> vnn1` on MATLAB/Octave command prompt.

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

-- vnn1: Script to upload a cluster or spherical dataset and view it;
   set random weights to the neural network and visualise the intial
   network state; train the neural network on the data; view neural
   network performance on training and test datasets and visualise
   final categorisation of dataset space.

-- Currently, visualising neural network learning is only supported
   for 2D data; however, n-D data can be learned.  


# Functionality to add

-- Add visualisation of cost function on Test Set data during training
   (to fmincgv.m)

-- Add neural network % performance to subplot titles for final
   Training Set and Test Set visualisations (to vnn1.m)

-- Visualise hidden units for 2D data

-- Implement user choice about uploading saved dataset or generating new
   dataset (via menu interface)

-- Visualisation of neural network learning and hidden units fo n-D
   data, n >= 3, on 2D and 3D scatter plots.

-- Make neural network structure (no. of hidden layers, number of
   units in each layer) flexible and selected by user

-- More dataset distribution shapes, including "ribbons"

-- Implement validation step(s) between training and testing



# Known bugs
-- Has only been tested on OS X (MacBook Pro)

-- On some OX S systems,when using Octave with GNUPLOT qt, 3D scatter
   plot background is black by default and must be changed to white
   manually by user to improve visualisation


