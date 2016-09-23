# PatrolImprovisation

Problem: Patrol an area with a robot begin as unpredictable as possible.
Intuitively, the robot must visit all the nodes of a graph infinitely often, minimizing the average idleness time (i.e., the time between two consecutive visits of the same node).

Technique: Assign probabilities to the graph’s edges such that the resulting Markov chain has a uniform stationary distribution and maximum entropy. The probabilities can be found by maximizing a nonlinear convex entropy function subject to the constraint that the transition matrix is doubly stochastic (i.e., both rows and columns sum to one).

As a case study, we consider the UC Berkely campus and a drone patrolling its buildings.

To run the demo, execute UBC/demo.m
