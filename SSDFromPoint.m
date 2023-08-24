% Written by Spencer Kraisler

function out = SSDFromPoint(x, x0, M)
    % Computes the sum of the squared geodesic distances of a set of points
    % from a point on a manifold.
    % x: cell of points on a manifold object
    % x0: the point on the manifold we are computing distances from
    % M: manifold object
    % Returns: scalar of the sum of squared geodesic distances of the
    % points from x0, divided by 2. 
    N = length(x);
    out = 0;
    for i = 1:N
        x_i = x{i};
        out = out + M.dist(x_i, x0)^2/2;
    end
end