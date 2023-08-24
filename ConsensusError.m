% Written by Spencer Kraisler

function out = ConsensusError(x, M, G)
    % Computes half the sum of the squared geodesic distances of each edge 
    % pair of points in a graph
    % x: cell of N vectors/matrices of positions of the points in the
    % manifold
    % M: manifold object 
    % G: undirected graph object
    % output: scalar of the consensus error
    out = 0;
    for edge = G.Edges.EndNodes' % iterate through the edges in the graph
        i = edge(1); j = edge(2);
        x_i = x{i}; x_j = x{j};

        out = out + M.dist(x_i,x_j)^2/2; 
    end
end