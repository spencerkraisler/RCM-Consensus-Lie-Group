# RCM-Consensus-Lie-Group

This repo is an implementation of the algorithm from the paper [Consensus on Lie groups for
the Riemannian Center of Mass](https://arxiv.org/abs/2308.08054). 

Just run ``main.m``.

``ConsensusError.m`` is a function that computes the geodesic variance, aka consensus error, of a set of points under a graph on a manifold. ``RiemannianCenterOfMass.m`` computes the Riemannian center of mass of a set of points on a manifold. ``SSDFromPoint.m`` computes the sum of squared geodesic distances over a set of points from a target point. Lastly, ``main.m`` is the file that contains the algorithm. Run it, and it will plot the RCM error and consensus error over time. The number of agents is set to 10, the tolernace is set to $10^{-6}$, and the max time is set to 20 with $\Delta t=.1$. The manifold of choice is $\mathcal{M}=SO(5)$, however you can switch that out for any Lie group with bi-invariant metric you want. 

# Dependencies
These files require the matlab Manopt library to run. Follow the [installation instructions](https://www.manopt.org/downloads.html), but the basic instructions are
1. Download the MATLAB Manopt library
2. Move the Manopt directory to your MATLAB directory
3. In the MATLAB console, cd into the Manopt directory
4. Type ``importmanopt`` in the MATLAB console


For any issues, please post an issue here, or contact me at kraisler(at)uw(dot)edu! I am always happy to help and explain anything!  
