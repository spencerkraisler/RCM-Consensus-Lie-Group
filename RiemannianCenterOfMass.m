% Written by Spencer Kraisler

function out = RiemannianCenterOfMass(x, M)
    % Computes the Riemannian center of mass (RCM) of a set of points on a
    % manifold.
    % x: cell of N vectors/matrices of positions of the points in the
    % manifold
    % M: Manifold object
    % out: RCM of the input point set
    tol = 1e-8;
    N = length(x);
    out = x{1};
    while true
        xi = M.zerovec(out);
        for i = 1:N
            x_i = x{i};
            xi = xi + M.log(out, x_i);
        end
        xi = xi/N;
        out = M.exp(out,xi);
        if norm(xi, 'fro') < tol
            break;
        end
    end
end