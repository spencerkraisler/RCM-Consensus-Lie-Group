% Written by Spencer Kraisler

function G = RandomConnectedGraph(n, p)
    % Generates a random connected graph.
    % n: number of nodes
    % p: probability of 2 nodes being adjacent
    % out: graph object
    is_connected = 0;
    while is_connected == 0
        A = rand(n); 
        A(A < 1 - p) = 0; 
        A(A >= 1 - p) = 1;
        A = A - diag(diag(A)); 
        A = tril(A) + tril(A)';
        G = graph(A);
        [~, bin_sizes] = conncomp(G);
        if bin_sizes(1) == n
            is_connected = 1;
        end
    end
end